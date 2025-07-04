import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../booking/presentation/providers/app_state.dart';



class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<AppState>().favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Styles'),
        backgroundColor: const Color(0xFFa78bfa),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet.'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final style = favorites[index];
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
              onPressed: () {
                context.read<AppState>().removeFavorite(style);
              },
            ),
          );
        },
      ),
    );
  }
}
