import 'package:flutter/material.dart';

class PaymentContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  const PaymentContinueButton({required this.onPressed, this.isLoading = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFa78bfa),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Continue to Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
} 