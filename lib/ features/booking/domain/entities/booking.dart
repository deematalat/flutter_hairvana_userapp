import 'package:flutter/material.dart';

class Booking {
  final String salon;
  final String stylist;
  final String style;
  final DateTime date;
  final TimeOfDay time;

  Booking({
    required this.salon,
    required this.stylist,
    required this.style,
    required this.date,
    required this.time,
  });
}
