import 'package:flutter/material.dart';

class PaymentConfirmButton extends StatelessWidget {
  final bool enabled;
  final bool isProcessing;
  final VoidCallback? onPressed;
  final String label;
  const PaymentConfirmButton({required this.enabled, required this.isProcessing, required this.onPressed, required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled && !isProcessing ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
          backgroundColor: enabled ? const Color(0xFFa78bfa) : Colors.grey[400],
          foregroundColor: Colors.white,
        ),
        child: isProcessing
            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
} 