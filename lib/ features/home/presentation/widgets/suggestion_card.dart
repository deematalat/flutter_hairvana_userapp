import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/styles/text_styles.dart';



class SuggestionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final double height;
  final VoidCallback? onTap;

  const SuggestionCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.height,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFF5EFFF),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            const SizedBox(width: 18),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFFE9D5FF),
                shape: BoxShape.circle,
              ),
              child: FaIcon(icon, color: Color(0xFFa78bfa), size: 22),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.button(color: Color(0xFFa21caf), fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: AppTextStyles.body(color: Colors.black87, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFFa78bfa), size: 18),
            const SizedBox(width: 18),
          ],
        ),
      ),
    );
  }
}
