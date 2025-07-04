import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../main.dart';
import '../widgets/app_gradient_appbar.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../data/fake_data/styles_items.dart';
import '../widgets/action_card.dart';
import '../widgets/suggestion_card.dart';
import '../widgets/trending_style_card.dart';


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
                  child: Column(
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 28, horizontalPadding, 0),
                  child: isWide
                      ? Row(
                    children: [
                      Expanded(
                        child: ActionCard(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
                          ),
                          icon: FontAwesomeIcons.camera,
                          iconSize: actionCardIconSize,
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
                          iconSize: actionCardIconSize,
                          title: 'AI Coach',
                          subtitle: 'Get personalized advice',
                          onTap: () => MainNavigation.navigateToTab(context, 4),
                          height: cardHeight,
                        ),
                      ),
                    ],
                  )
                      : Column(
                    children: [
                      ActionCard(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
                        ),
                        icon: FontAwesomeIcons.camera,
                        iconSize: actionCardIconSize,
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
                        iconSize: actionCardIconSize,
                        title: 'AI Coach',
                        subtitle: 'Get personalized advice',
                        onTap: () => MainNavigation.navigateToTab(context, 4),
                        height: cardHeight,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 32, horizontalPadding, 0),
                  child: Row(
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
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 18, horizontalPadding, 0),
                  child: isWide
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
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 32, horizontalPadding, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trending Styles',
                        style: AppTextStyles.title(fontSize: isWide ? 26 : 22),
                      ),
                      TextButton(
                        onPressed: () => MainNavigation.navigateToTab(context, 2),
                        child: Text(
                          'View All',
                          style: AppTextStyles.body(
                            color: const Color(0xFFa78bfa),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: trendingCardWidth + 32,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 0),
                    children: [
                      for (final item in styleItems.where((item) => item.trending))
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: TrendingStyleCard(
                            item: item,
                            width: trendingCardWidth,
                          ),
                        ),
                    ],
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
