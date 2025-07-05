import 'package:flutter/material.dart';

class AiSuggestionsCard extends StatelessWidget {
  final String suggestion;
  const AiSuggestionsCard({required this.suggestion, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFF3CD)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.tips_and_updates, color: Color(0xFFFFC107)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              suggestion,
              style: const TextStyle(color: Color(0xFF856404)),
            ),
          ),
        ],
      ),
    );
  }
} 