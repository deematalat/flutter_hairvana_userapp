import 'package:flutter/material.dart';

class MatchBadge extends StatelessWidget {
  const MatchBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 80,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFFa78bfa), Color(0xFFf472b6)]),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Row(
          children: [
            Icon(Icons.star, color: Colors.white, size: 20),
            SizedBox(width: 6),
            Text('87%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(width: 4),
            Text('AI Match', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
} 