part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

final class ProceedPayment extends PaymentEvent {
  final int amount;

  ProceedPayment({required this.amount});
}
