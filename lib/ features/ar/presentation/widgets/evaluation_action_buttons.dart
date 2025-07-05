import 'package:flutter/material.dart';

class EvaluationActionButtons extends StatelessWidget {
  final VoidCallback onTryAnother;
  final VoidCallback onBookNow;
  const EvaluationActionButtons({required this.onTryAnother, required this.onBookNow, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onTryAnother,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              side: const BorderSide(color: Color(0xFFE0E0E0)),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Try Another', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: ElevatedButton(
            onPressed: onBookNow,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              backgroundColor: const Color(0xFFa78bfa),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Book Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      ],
    );
  }
} 