import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/styles/text_styles.dart';

class OnboardingPage extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Size size;
  const OnboardingPage({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconSize = size.width * 0.18;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(icon, size: iconSize.clamp(50, 100), color: iconColor),
        SizedBox(height: size.height * 0.04),
        Text(
          title,
          style: AppTextStyles.title(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: size.height * 0.025),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Text(
            subtitle,
            style: AppTextStyles.subtitle(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
} 