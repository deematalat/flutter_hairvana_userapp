import 'package:flutter/material.dart';
import '../../../home/presentation/domain/entities/style_item.dart';
import 'style_card.dart';

class GalleryStyleGrid extends StatelessWidget {
  final List<StyleItem> items;
  final List<StyleItem> favorites;
  final ValueChanged<StyleItem> onFavorite;
  const GalleryStyleGrid({
    required this.items,
    required this.favorites,
    required this.onFavorite,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        final isFavorite = favorites.contains(item);
        return StyleCard(
          item: item,
          isFavorite: isFavorite,
          onFavorite: () => onFavorite(item),
        );
      },
    );
  }
} 