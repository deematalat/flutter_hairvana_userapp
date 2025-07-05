import 'package:flutter/material.dart';
import '../../../../core/styles/text_styles.dart';

class HomeHeader extends StatelessWidget {
  final bool isWide;
  const HomeHeader({required this.isWide, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: isWide ? 48 : 38,
              height: isWide ? 48 : 38,
            ),
            const SizedBox(width: 10),
            Text(
              'Hairvana',
              style: AppTextStyles.title(
                color: const Color(0xFFa21caf),
                fontSize: isWide ? 38 : 32,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Discover your perfect hairstyle with AI-powered recommendations and AR try-on',
          style: AppTextStyles.subtitle(
            color: Colors.black87,
            fontSize: isWide ? 22 : 18,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
} 