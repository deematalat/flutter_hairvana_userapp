import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingState(
    selectedDate: DateTime.now(),
    selectedTime: const TimeOfDay(hour: 9, minute: 0),
  )) {
    on<BookingDateSelected>(_onDateSelected);
    on<BookingTimeSelected>(_onTimeSelected);
    on<BookingConfirmed>(_onBookingConfirmed);
  }

  void _onDateSelected(BookingDateSelected event, Emitter<BookingState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  void _onTimeSelected(BookingTimeSelected event, Emitter<BookingState> emit) {
    emit(state.copyWith(selectedTime: event.time));
  }

  void _onBookingConfirmed(BookingConfirmed event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo purposes, always succeed
      emit(state.copyWith(isLoading: false, success: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Failed to confirm booking. Please try again.'));
    }
  }
} 