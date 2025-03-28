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
    on<ForgotPassword>(_forgotPassword);
    on<GetLogginedUser>(_getLogginedUser);
    on<LogoutRequested>(_logoutRequested);
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

  Future<void> _forgotPassword(
      ForgotPassword event, Emitter<LoginState> emit) async {
    try {
      bool success = await loginRepo.sendPasswordResetEmail(event.email);
      if (success == true) {
        emit(PasswordResetMailSent());
      }
    } catch (e) {
      print(e);
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

  Future<void> _logoutRequested(
      LogoutRequested event, Emitter<LoginState> emit) async {
    await loginRepo.signOut();
    emit(LogoutSuccess());
  }
}
