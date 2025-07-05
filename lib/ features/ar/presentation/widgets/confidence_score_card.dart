import 'package:flutter/material.dart';

class ConfidenceScoreCard extends StatelessWidget {
  final String score;
  final String message;
  const ConfidenceScoreCard({required this.score, required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(score, style: const TextStyle(color: Color(0xFFa21caf), fontWeight: FontWeight.bold, fontSize: 44)),
          const SizedBox(height: 8),
          const Text('Confidence Score', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 4),
          Text(message, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
} 