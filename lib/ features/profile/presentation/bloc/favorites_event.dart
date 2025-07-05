import 'package:equatable/equatable.dart';
import '../../../home/presentation/domain/entities/style_item.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {}
class RemoveFavorite extends FavoritesEvent {
  final StyleItem style;
  const RemoveFavorite(this.style);
  @override
  List<Object?> get props => [style];
} 