import 'package:flutter_bloc/flutter_bloc.dart';
import 'gallery_event.dart';
import 'gallery_state.dart';
import '../../../home/data/fake_data/styles_items.dart';
import '../../../home/presentation/domain/entities/style_item.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(GalleryState(filteredItems: styleItems)) {
    on<GallerySearchChanged>((event, emit) {
      final filtered = _filterItems(event.query, state.selectedDifficulty);
      emit(state.copyWith(searchQuery: event.query, filteredItems: filtered));
    });
    on<GalleryFilterChanged>((event, emit) {
      final filtered = _filterItems(state.searchQuery, event.difficulty);
      emit(state.copyWith(selectedDifficulty: event.difficulty, filteredItems: filtered));
    });
    on<GalleryToggleFavorite>((event, emit) {
      final newFavorites = List<StyleItem>.from(state.favorites);
      if (newFavorites.contains(event.item)) {
        newFavorites.remove(event.item);
      } else {
        newFavorites.add(event.item);
      }
      emit(state.copyWith(favorites: newFavorites));
    });
  }

  List<StyleItem> _filterItems(String query, String? difficulty) {
    return styleItems.where((item) {
      final matchesSearch = item.name.toLowerCase().contains(query.toLowerCase());
      final matchesDifficulty = difficulty == null || item.difficulty == difficulty;
      return matchesSearch && matchesDifficulty;
    }).toList();
  }
} 