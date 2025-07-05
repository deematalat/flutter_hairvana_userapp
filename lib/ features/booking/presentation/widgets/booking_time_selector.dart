import 'package:flutter/material.dart';

class BookingTimeSelector extends StatelessWidget {
  final TimeOfDay selectedTime;
  final VoidCallback onTap;

  const BookingTimeSelector({
    Key? key,
    required this.selectedTime,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(
              Icons.access_time,
              color: Colors.grey.shade600,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              'Time',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const Spacer(),
            Text(
              selectedTime.format(context),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
} 