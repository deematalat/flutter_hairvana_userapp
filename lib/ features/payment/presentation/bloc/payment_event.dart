import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentOptionSelected extends PaymentEvent {
  final int option;
  PaymentOptionSelected(this.option);
  @override
  List<Object?> get props => [option];
}

class PaymentContinuePressed extends PaymentEvent {} 