import 'package:flutter/material.dart';

class BookingsEmptyState extends StatelessWidget {
  const BookingsEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('No bookings yet.'));
  }
} 