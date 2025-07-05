import 'package:equatable/equatable.dart';
import '../../domain/entities/booking.dart';
import 'package:flutter/material.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookingDateSelected extends BookingEvent {
  final DateTime date;
  BookingDateSelected(this.date);
  @override
  List<Object?> get props => [date];
}

class BookingTimeSelected extends BookingEvent {
  final TimeOfDay time;
  BookingTimeSelected(this.time);
  @override
  List<Object?> get props => [time];
}

class BookingConfirmed extends BookingEvent {
  final Booking booking;
  BookingConfirmed(this.booking);
  @override
  List<Object?> get props => [booking];
} 