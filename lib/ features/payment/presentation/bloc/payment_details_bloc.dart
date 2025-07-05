import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_details_event.dart';
import 'payment_details_state.dart';

class PaymentDetailsBloc extends Bloc<PaymentDetailsEvent, PaymentDetailsState> {
  PaymentDetailsBloc() : super(const PaymentDetailsState()) {
    on<PaymentTypeSelected>(_onPaymentTypeSelected);
    on<PaymentCardFieldChanged>(_onCardFieldChanged);
    on<PaymentDetailsSubmitted>(_onPaymentSubmitted);
  }

  void _onPaymentTypeSelected(PaymentTypeSelected event, Emitter<PaymentDetailsState> emit) {
    emit(state.copyWith(selectedType: event.type));
  }

  void _onCardFieldChanged(PaymentCardFieldChanged event, Emitter<PaymentDetailsState> emit) {
    emit(state.copyWith(
      cardNumber: event.cardNumber,
      expiry: event.expiry,
      cvv: event.cvv,
      saveCard: event.saveCard,
    ));
  }

  void _onPaymentSubmitted(PaymentDetailsSubmitted event, Emitter<PaymentDetailsState> emit) async {
    emit(state.copyWith(isProcessing: true, error: null));
    
    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));
      
      // For demo purposes, always succeed
      emit(state.copyWith(isProcessing: false, success: true));
    } catch (e) {
      emit(state.copyWith(
        isProcessing: false,
        error: 'Payment failed. Please try again.',
      ));
    }
  }
} 