import 'package:flutter/material.dart';

class BookingDateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onTap;
  const BookingDateSelector({required this.selectedDate, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.grey),
              const SizedBox(width: 12),
              Text('Today,  ${selectedDate.month}/${selectedDate.day}', style: const TextStyle(fontSize: 16)),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
} 