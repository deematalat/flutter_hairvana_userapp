import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/gallery_bloc.dart';
import '../bloc/gallery_event.dart';
import '../bloc/gallery_state.dart';
import '../widgets/gallery_app_bar.dart';
import '../widgets/gallery_search_filter.dart';
import '../widgets/gallery_style_grid.dart';


class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GalleryBloc(),
      child: Scaffold(
        appBar: const GalleryAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              BlocBuilder<GalleryBloc, GalleryState>(
                builder: (context, state) {
                  return GallerySearchFilter(
                    searchQuery: state.searchQuery,
                    selectedDifficulty: state.selectedDifficulty,
                    onSearchChanged: (query) => context.read<GalleryBloc>().add(GallerySearchChanged(query)),
                    onFilterChanged: (difficulty) => context.read<GalleryBloc>().add(GalleryFilterChanged(difficulty)),
                  );
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<GalleryBloc, GalleryState>(
                  builder: (context, state) {
                    return GalleryStyleGrid(
                      items: state.filteredItems,
                      favorites: state.favorites,
                      onFavorite: (item) => context.read<GalleryBloc>().add(GalleryToggleFavorite(item)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


