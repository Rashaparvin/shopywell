part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupViaEmailSuccess extends SignupState {
  final User user;

  SignupViaEmailSuccess({required this.user});
}

final class SignupViaEmailFailure extends SignupState {
  final String errorMessage;

  SignupViaEmailFailure({required this.errorMessage});
}
