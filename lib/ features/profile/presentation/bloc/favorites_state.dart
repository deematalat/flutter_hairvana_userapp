import 'package:equatable/equatable.dart';
import '../../../home/presentation/domain/entities/style_item.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();
  @override
  List<Object?> get props => [];
}

class FavoritesLoading extends FavoritesState {}
class FavoritesLoaded extends FavoritesState {
  final List<StyleItem> favorites;
  const FavoritesLoaded(this.favorites);
  @override
  List<Object?> get props => [favorites];
}
class FavoritesEmpty extends FavoritesState {}
class FavoritesError extends FavoritesState {
  final String message;
  const FavoritesError(this.message);
  @override
  List<Object?> get props => [message];
} 