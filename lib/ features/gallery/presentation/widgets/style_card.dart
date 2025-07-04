import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../home/presentation/domain/entities/style_item.dart';


class StyleCard extends StatelessWidget {
  final StyleItem item;
  final bool isFavorite;
  final VoidCallback onFavorite;

  const StyleCard({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(),
          _buildInfoSection(context),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          child: Image.network(
            item.imageUrl,
            height: 110,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 110,
              color: Colors.grey[200],
              child: const Icon(Icons.image, size: 40, color: Colors.grey),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Row(
            children: [
              if (item.trending)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('🔥 Trending',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              if (item.trending) const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getDifficultyColor(item.difficulty),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.difficulty,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.pink : Colors.grey[500],
            ),
            onPressed: onFavorite,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(item.type, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 2),
              Text(
                '${(item.rating * 100).toInt()}%',
                style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => MainNavigation.navigateToTab(context, 1),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFede9fe),
                foregroundColor: Colors.purple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: const Text('Try AR'),
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return Colors.green;
      case 'Medium':
        return Colors.amber;
      case 'Hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}