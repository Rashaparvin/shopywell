part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginViaEmail extends LoginEvent {
  final String email;
  final String password;

  LoginViaEmail({required this.email, required this.password});
}

final class LoginViaGoogle extends LoginEvent {}

final class GetLogginedUser extends LoginEvent {}

final class UpdatePassword extends LoginEvent {
  final String newPassword;

  UpdatePassword({required this.newPassword});
}
