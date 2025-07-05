import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<PaymentOptionSelected>((event, emit) {
      emit(state.copyWith(selectedOption: event.option));
    });
    on<PaymentContinuePressed>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(isLoading: false, success: true));
    });
  }
} 