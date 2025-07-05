import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../main.dart';
import 'action_card.dart';

class HomeActionCards extends StatelessWidget {
  final bool isWide;
  final double cardHeight;
  final double iconSize;
  const HomeActionCards({required this.isWide, required this.cardHeight, required this.iconSize, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isWide) {
      return Row(
        children: [
          Expanded(
            child: ActionCard(
              gradient: const LinearGradient(
                colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
              ),
              icon: FontAwesomeIcons.camera,
              iconSize: iconSize,
              title: 'AR Try-On',
              subtitle: 'See styles on you',
              onTap: () => MainNavigation.navigateToTab(context, 1),
              height: cardHeight,
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: ActionCard(
              gradient: const LinearGradient(
                colors: [Color(0xFF60a5fa), Color(0xFF818cf8)],
              ),
              icon: FontAwesomeIcons.comments,
              iconSize: iconSize,
              title: 'AI Coach',
              subtitle: 'Get personalized advice',
              onTap: () => MainNavigation.navigateToTab(context, 4),
              height: cardHeight,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          ActionCard(
            gradient: const LinearGradient(
              colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
            ),
            icon: FontAwesomeIcons.camera,
            iconSize: iconSize,
            title: 'AR Try-On',
            subtitle: 'See styles on you',
            onTap: () => MainNavigation.navigateToTab(context, 1),
            height: cardHeight,
          ),
          const SizedBox(height: 18),
          ActionCard(
            gradient: const LinearGradient(
              colors: [Color(0xFF60a5fa), Color(0xFF818cf8)],
            ),
            icon: FontAwesomeIcons.comments,
            iconSize: iconSize,
            title: 'AI Coach',
            subtitle: 'Get personalized advice',
            onTap: () => MainNavigation.navigateToTab(context, 4),
            height: cardHeight,
          ),
        ],
      );
    }
  }
} 