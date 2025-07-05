import 'package:flutter/material.dart';

class PaymentConfirmationDialog extends StatelessWidget {
  final String stylist;
  final String salon;
  final String style;
  final DateTime date;
  final TimeOfDay time;
  final VoidCallback onClose;
  const PaymentConfirmationDialog({required this.stylist, required this.salon, required this.style, required this.date, required this.time, required this.onClose, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green[50],
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(16),
              child: const Icon(Icons.check, color: Colors.green, size: 48),
            ),
            const SizedBox(height: 18),
            const Text('Booking Confirmed!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 12),
            Text(
              'Your appointment with $stylist at $salon for $style has been scheduled.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFf3e8ff),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "You'll receive a confirmation email shortly with all the details.",
                style: TextStyle(color: Color(0xFFa78bfa)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: onClose,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFa78bfa),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
} 