import 'package:flutter/material.dart';
import 'styled_bullet.dart';

class MaintenanceStylingCard extends StatelessWidget {
  final List<Map<String, dynamic>> bullets;
  const MaintenanceStylingCard({required this.bullets, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: bullets.map((b) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: StyledBullet(color: b['color'], text: b['text']),
        )).toList(),
      ),
    );
  }
} 