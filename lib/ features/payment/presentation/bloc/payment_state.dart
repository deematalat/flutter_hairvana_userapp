import 'package:equatable/equatable.dart';

class PaymentState extends Equatable {
  final int selectedOption;
  final bool isLoading;
  final String? error;
  final bool success;

  const PaymentState({
    this.selectedOption = 0,
    this.isLoading = false,
    this.error,
    this.success = false,
  });

  PaymentState copyWith({
    int? selectedOption,
    bool? isLoading,
    String? error,
    bool? success,
  }) {
    return PaymentState(
      selectedOption: selectedOption ?? this.selectedOption,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [selectedOption, isLoading, error, success];
} 