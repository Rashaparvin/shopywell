import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopywell/data/repository/payment_repo/payment_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;
  PaymentBloc(this.paymentRepository) : super(PaymentInitial()) {
    on<ProceedPayment>(_proceedPayment);
  }

  Future<void> _proceedPayment(
      ProceedPayment event, Emitter<PaymentState> emit) async {
    try {
      await paymentRepository.makePayment(event.amount);
      emit(PaymentSuccess());
    } catch (e) {
      print(e);
      emit(PaymentFailure(errMessage: e.toString()));
    }
  }
}
