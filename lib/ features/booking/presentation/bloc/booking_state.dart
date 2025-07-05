import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/booking.dart';

class BookingState extends Equatable {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final bool isLoading;
  final String? error;
  final bool success;

  const BookingState({
    required this.selectedDate,
    required this.selectedTime,
    this.isLoading = false,
    this.error,
    this.success = false,
  });

  BookingState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    bool? isLoading,
    String? error,
    bool? success,
  }) {
    return BookingState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [selectedDate, selectedTime, isLoading, error, success];
} 