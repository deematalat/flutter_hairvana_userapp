import 'package:flutter/material.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../main.dart';
import '../../data/fake_data/styles_items.dart';
import 'trending_style_card.dart';

class HomeTrendingStyles extends StatelessWidget {
  final bool isWide;
  final double trendingCardWidth;
  const HomeTrendingStyles({required this.isWide, required this.trendingCardWidth, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending Styles',
              style: AppTextStyles.title(fontSize: isWide ? 26 : 22),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MainNavigation(initialIndex: 2)),
                );
              },
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
        SizedBox(
          height: trendingCardWidth + 32,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
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
      ],
    );
  }
} 