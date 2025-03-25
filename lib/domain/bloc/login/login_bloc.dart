import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shopywell/data/repository/login_repo/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo loginRepo;
  LoginBloc(this.loginRepo) : super(LoginInitial()) {
    on<LoginViaEmail>(_loginViaEmail);
    on<LoginViaGoogle>(_loginViaGoogle);
    on<UpdatePassword>(_updatePassword);
    on<GetLogginedUser>(_getLogginedUser);
  }

  Future<void> _loginViaEmail(
      LoginViaEmail event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInitial());
      final email = event.email;
      final password = event.password;
      final userAuth = await loginRepo.signInWithEmail(email, password);
      if (userAuth != null) {
        emit(LoginViaEmailSuccess(user: userAuth));
      } else {
        emit(LoginViaEmailFailure(
            errorMessage: 'User authentication failed !!'));
      }
    } catch (e) {
      emit(LoginViaEmailFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _loginViaGoogle(
      LoginViaGoogle event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInitial());
      final userAuth = await loginRepo.signInWithGoogle();
      if (userAuth != null) {
        emit(LoginViaGoogleSuccess(user: userAuth));
      } else {
        emit(LoginViaGoogleFailure(
            errorMessage: 'User authentication using google is failed !!'));
      }
    } catch (e) {
      emit(LoginViaGoogleFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _updatePassword(
      UpdatePassword event, Emitter<LoginState> emit) async {
    try {
      bool success = await loginRepo.updatePassword(event.newPassword);
      if (success == true) {
        emit(PasswordUpdated());
      } else {
        emit(PasswordUpdateError());
      }
    } catch (e) {
      print(e);
      emit(PasswordUpdateError());
    }
  }

  Future<void> _getLogginedUser(
      GetLogginedUser event, Emitter<LoginState> emit) async {
    emit(LoginUserChecking());
    final user = loginRepo.getCurrentUser();
    if (user!.email != '') {
      emit(LoginUserFound(
        user: user.displayName ?? '',
        userEmail: user.email ?? '',
      ));
    }
  }
}
