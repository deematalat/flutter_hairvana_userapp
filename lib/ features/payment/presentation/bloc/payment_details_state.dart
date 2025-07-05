import 'package:equatable/equatable.dart';

class PaymentDetailsState extends Equatable {
  final int? selectedType;
  final String cardNumber;
  final String expiry;
  final String cvv;
  final bool saveCard;
  final bool isProcessing;
  final bool success;
  final String? error;

  const PaymentDetailsState({
    this.selectedType,
    this.cardNumber = '',
    this.expiry = '',
    this.cvv = '',
    this.saveCard = false,
    this.isProcessing = false,
    this.success = false,
    this.error,
  });

  PaymentDetailsState copyWith({
    int? selectedType,
    String? cardNumber,
    String? expiry,
    String? cvv,
    bool? saveCard,
    bool? isProcessing,
    bool? success,
    String? error,
  }) {
    return PaymentDetailsState(
      selectedType: selectedType ?? this.selectedType,
      cardNumber: cardNumber ?? this.cardNumber,
      expiry: expiry ?? this.expiry,
      cvv: cvv ?? this.cvv,
      saveCard: saveCard ?? this.saveCard,
      isProcessing: isProcessing ?? this.isProcessing,
      success: success ?? this.success,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    selectedType,
    cardNumber,
    expiry,
    cvv,
    saveCard,
    isProcessing,
    success,
    error,
  ];
} 