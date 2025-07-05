import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../main.dart';
import 'suggestion_card.dart';

class HomeSuggestions extends StatelessWidget {
  final bool isWide;
  final double suggestionCardHeight;
  const HomeSuggestions({required this.isWide, required this.suggestionCardHeight, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.wandMagicSparkles,
              color: const Color(0xFFa78bfa),
              size: isWide ? 26 : 22,
            ),
            const SizedBox(width: 8),
            Text(
              'AI Suggestions for You',
              style: AppTextStyles.title(fontSize: isWide ? 26 : 22),
            ),
          ],
        ),
        const SizedBox(height: 18),
        isWide
            ? Row(
                children: [
                  Expanded(
                    child: SuggestionCard(
                      icon: FontAwesomeIcons.scissors,
                      title: 'Try a shorter cut',
                      subtitle: 'Based on your face shape, a bob would be perfect',
                      height: suggestionCardHeight,
                      onTap: () => MainNavigation.navigateToTab(context, 1),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: SuggestionCard(
                      icon: FontAwesomeIcons.palette,
                      title: 'Add some highlights',
                      subtitle: 'Caramel highlights would complement your skin tone',
                      height: suggestionCardHeight,
                      onTap: () => MainNavigation.navigateToTab(context, 2),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  SuggestionCard(
                    icon: FontAwesomeIcons.scissors,
                    title: 'Try a shorter cut',
                    subtitle: 'Based on your face shape, a bob would be perfect',
                    height: suggestionCardHeight,
                    onTap: () => MainNavigation.navigateToTab(context, 1),
                  ),
                  const SizedBox(height: 14),
                  SuggestionCard(
                    icon: FontAwesomeIcons.palette,
                    title: 'Add some highlights',
                    subtitle: 'Caramel highlights would complement your skin tone',
                    height: suggestionCardHeight,
                    onTap: () => MainNavigation.navigateToTab(context, 2),
                  ),
                ],
              ),
      ],
    );
  }
} 