part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginViaEmailSuccess extends LoginState {
  final User user;

  LoginViaEmailSuccess({required this.user});
}

final class LoginViaEmailFailure extends LoginState {
  final String errorMessage;

  LoginViaEmailFailure({required this.errorMessage});
}

final class LoginViaGoogleSuccess extends LoginState {
  final User user;

  LoginViaGoogleSuccess({required this.user});
}

final class LoginViaGoogleFailure extends LoginState {
  final String errorMessage;

  LoginViaGoogleFailure({required this.errorMessage});
}

final class LoginUserFound extends LoginState {}

final class LoginUserChecking extends LoginState {}
