import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/styles/text_styles.dart';


class ActionCard extends StatelessWidget {
  final LinearGradient gradient;
  final IconData icon;
  final double iconSize;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final double height;

  const ActionCard({
    Key? key,
    required this.gradient,
    required this.icon,
    required this.iconSize,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.10),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            children: [
              FaIcon(icon, color: Colors.white, size: iconSize),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.button(fontSize: 18)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: AppTextStyles.body(color: Colors.white70, fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
