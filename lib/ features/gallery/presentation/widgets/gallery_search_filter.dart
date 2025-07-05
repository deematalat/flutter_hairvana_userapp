import 'package:flutter/material.dart';

class GallerySearchFilter extends StatelessWidget {
  final String searchQuery;
  final String? selectedDifficulty;
  final Function(String) onSearchChanged;
  final Function(String?) onFilterChanged;

  const GallerySearchFilter({
    Key? key,
    required this.searchQuery,
    required this.selectedDifficulty,
    required this.onSearchChanged,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            onChanged: onSearchChanged,
            decoration: const InputDecoration(
              hintText: 'Search styles...',
              border: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FilterChip(
                label: const Text('All'),
                selected: selectedDifficulty == null,
                onSelected: (selected) => onFilterChanged(null),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Easy'),
                selected: selectedDifficulty == 'Easy',
                onSelected: (selected) => onFilterChanged('Easy'),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Medium'),
                selected: selectedDifficulty == 'Medium',
                onSelected: (selected) => onFilterChanged('Medium'),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Hard'),
                selected: selectedDifficulty == 'Hard',
                onSelected: (selected) => onFilterChanged('Hard'),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 