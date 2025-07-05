import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';
import '../../../home/presentation/domain/entities/style_item.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesLoading()) {
    List<StyleItem> _favorites = [
      StyleItem(
        name: 'Beach Waves',
        type: 'Wavy',
        imageUrl: 'https://example.com/beach_waves.jpg',
        trending: true,
        difficulty: 'Medium',
        rating: 4.5,
        tag: 'Summer',
      ),
      StyleItem(
        name: 'Curtain Bangs',
        type: 'Bangs',
        imageUrl: 'https://example.com/curtain_bangs.jpg',
        trending: false,
        difficulty: 'Easy',
        rating: 4.2,
        tag: 'Trendy',
      ),
    ];
    on<LoadFavorites>((event, emit) async {
      emit(FavoritesLoading());
      await Future.delayed(const Duration(milliseconds: 300));
      if (_favorites.isEmpty) {
        emit(FavoritesEmpty());
      } else {
        emit(FavoritesLoaded(List.from(_favorites)));
      }
    });
    on<RemoveFavorite>((event, emit) async {
      _favorites.remove(event.style);
      if (_favorites.isEmpty) {
        emit(FavoritesEmpty());
      } else {
        emit(FavoritesLoaded(List.from(_favorites)));
      }
    });
  }
} 