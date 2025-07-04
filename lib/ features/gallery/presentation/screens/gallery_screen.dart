import 'package:flutter/material.dart';
import '../../../home/data/fake_data/styles_items.dart';
import '../../../home/presentation/domain/entities/style_item.dart';
import '../widgets/style_card.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  static final List<StyleItem> favorites = [];

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String searchQuery = '';
  String? selectedDifficulty;

  List<StyleItem> get filteredItems {
    return styleItems.where((item) {
      final matchesSearch = item.name.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesDifficulty = selectedDifficulty == null || item.difficulty == selectedDifficulty;
      return matchesSearch && matchesDifficulty;
    }).toList();
  }

  void toggleFavorite(StyleItem item) {
    setState(() {
      GalleryScreen.favorites.contains(item)
          ? GalleryScreen.favorites.remove(item)
          : GalleryScreen.favorites.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            _buildSearchAndFilter(),
            const SizedBox(height: 16),
            Expanded(child: _buildGrid()),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Style Gallery',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      flexibleSpace: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search styles...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            onChanged: (value) => setState(() => searchQuery = value),
          ),
        ),
        const SizedBox(width: 12),
        PopupMenuButton<String>(
          icon: const Icon(Icons.filter_alt_outlined),
          onSelected: (value) =>
              setState(() => selectedDifficulty = value == 'All' ? null : value),
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'All', child: Text('All')),
            PopupMenuItem(value: 'Easy', child: Text('Easy')),
            PopupMenuItem(value: 'Medium', child: Text('Medium')),
            PopupMenuItem(value: 'Hard', child: Text('Hard')),
          ],
        ),
      ],
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (_, index) {
        final item = filteredItems[index];
        final isFavorite = GalleryScreen.favorites.contains(item);
        return StyleCard(
          item: item,
          isFavorite: isFavorite,
          onFavorite: () => toggleFavorite(item),
        );
      },
    );
  }
}


