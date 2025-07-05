import 'package:equatable/equatable.dart';

abstract class PaymentDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentTypeSelected extends PaymentDetailsEvent {
  final int type;
  PaymentTypeSelected(this.type);
  @override
  List<Object?> get props => [type];
}

class PaymentCardFieldChanged extends PaymentDetailsEvent {
  final String cardNumber;
  final String expiry;
  final String cvv;
  final bool saveCard;
  
  PaymentCardFieldChanged({
    required this.cardNumber,
    required this.expiry,
    required this.cvv,
    required this.saveCard,
  });
  
  @override
  List<Object?> get props => [cardNumber, expiry, cvv, saveCard];
}

class PaymentDetailsSubmitted extends PaymentDetailsEvent {} 