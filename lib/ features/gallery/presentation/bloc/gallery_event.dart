import 'package:equatable/equatable.dart';
import '../../../home/presentation/domain/entities/style_item.dart';

abstract class GalleryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GallerySearchChanged extends GalleryEvent {
  final String query;
  GallerySearchChanged(this.query);
  @override
  List<Object?> get props => [query];
}

class GalleryFilterChanged extends GalleryEvent {
  final String? difficulty;
  GalleryFilterChanged(this.difficulty);
  @override
  List<Object?> get props => [difficulty];
}

class GalleryToggleFavorite extends GalleryEvent {
  final StyleItem item;
  GalleryToggleFavorite(this.item);
  @override
  List<Object?> get props => [item];
} 