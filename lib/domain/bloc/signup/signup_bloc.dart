import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shopywell/data/repository/signup_repository/signup_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupRepository signupRepository;
  SignupBloc(this.signupRepository) : super(SignupInitial()) {
    on<SignupViaEmail>(_signupViaEmail);
  }

  Future<void> _signupViaEmail(
      SignupViaEmail event, Emitter<SignupState> emit) async {
    try {
      emit(SignupInitial());
      final userAuth =
          await signupRepository.signUpWithEmail(event.email, event.password);
      if (userAuth != null) {
        emit(SignupViaEmailSuccess(user: userAuth));
      } else {
        emit(SignupViaEmailFailure(errorMessage: 'User authentication failed'));
      }
    } catch (e) {
      emit(SignupViaEmailFailure(errorMessage: e.toString()));
    }
  }
}
