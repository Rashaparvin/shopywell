part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

final class SignupViaEmail extends SignupEvent {
  final String email;
  final String password;

  SignupViaEmail({required this.email, required this.password});
}

final class SignupViaGoogle extends SignupEvent {}
