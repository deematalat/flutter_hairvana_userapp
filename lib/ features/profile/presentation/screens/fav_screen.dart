import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';
import '../../../home/presentation/domain/entities/style_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesBloc()..add(LoadFavorites()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Styles'),
          backgroundColor: const Color(0xFFa78bfa),
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoritesEmpty) {
              return const Center(child: Text('No favorites yet.'));
            } else if (state is FavoritesLoaded) {
              final favorites = state.favorites;
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final style = favorites[index];
                  return FavoriteStyleListItem(
                    style: style,
                    onDelete: () {
                      context.read<FavoritesBloc>().add(RemoveFavorite(style));
                    },
                  );
                },
              );
            } else if (state is FavoritesError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class FavoriteStyleListItem extends StatelessWidget {
  final StyleItem style;
  final VoidCallback onDelete;
  const FavoriteStyleListItem({Key? key, required this.style, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        style.imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
      title: Text(style.name),
      subtitle: Text(style.type),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.redAccent),
        onPressed: onDelete,
      ),
    );
  }
}
