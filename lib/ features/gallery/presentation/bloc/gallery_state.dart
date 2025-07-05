import 'package:equatable/equatable.dart';
import '../../../home/presentation/domain/entities/style_item.dart';

class GalleryState extends Equatable {
  final List<StyleItem> filteredItems;
  final String searchQuery;
  final String? selectedDifficulty;
  final List<StyleItem> favorites;

  const GalleryState({
    required this.filteredItems,
    this.searchQuery = '',
    this.selectedDifficulty,
    this.favorites = const [],
  });

  GalleryState copyWith({
    List<StyleItem>? filteredItems,
    String? searchQuery,
    String? selectedDifficulty,
    List<StyleItem>? favorites,
  }) {
    return GalleryState(
      filteredItems: filteredItems ?? this.filteredItems,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedDifficulty: selectedDifficulty,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object?> get props => [filteredItems, searchQuery, selectedDifficulty, favorites];
} 