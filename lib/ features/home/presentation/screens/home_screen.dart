import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../main.dart';
import '../widgets/app_gradient_appbar.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../data/fake_data/styles_items.dart';
import '../widgets/home_header.dart';
import '../widgets/home_action_cards.dart';
import '../widgets/home_suggestions.dart';
import '../widgets/home_trending_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          final size = MediaQuery.of(context).size;
          final double horizontalPadding =
              (isWide ? size.width * 0.15 : size.width * 0.06).clamp(16, 80).toDouble();
          final double cardHeight =
              (isWide ? 130 : size.height * 0.13).clamp(90, 140).toDouble();
          final double actionCardIconSize =
              (isWide ? 44 : size.width * 0.09).clamp(32, 48).toDouble();
          final double suggestionCardHeight =
              (isWide ? 100 : size.height * 0.11).clamp(70, 110).toDouble();
          final double trendingCardWidth =
              (isWide ? size.width * 0.22 : size.width * 0.38).clamp(120, 220).toDouble();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppGradientAppBar(
                  title: 'Hairvana',
                  subtitle: 'Your personal style companion',
                  onProfileTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProfileScreen()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 32, horizontalPadding, 0),
                  child: HomeHeader(isWide: isWide),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 28, horizontalPadding, 0),
                  child: HomeActionCards(
                    isWide: isWide,
                    cardHeight: cardHeight,
                    iconSize: actionCardIconSize,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 32, horizontalPadding, 0),
                  child: HomeSuggestions(
                    isWide: isWide,
                    suggestionCardHeight: suggestionCardHeight,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 32, horizontalPadding, 0),
                  child: HomeTrendingStyles(
                    isWide: isWide,
                    trendingCardWidth: trendingCardWidth,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
