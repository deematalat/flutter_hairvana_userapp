import 'package:flutter/material.dart';

class BookingContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  const BookingContinueButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
          backgroundColor: const Color(0xFFa78bfa),
          foregroundColor: Colors.white,
        ),
        child: const Text('Continue to Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
} 