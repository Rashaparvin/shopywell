part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentSuccess extends PaymentState {}

final class PaymentFailure extends PaymentState {
  final String errMessage;

  PaymentFailure({required this.errMessage});
}
