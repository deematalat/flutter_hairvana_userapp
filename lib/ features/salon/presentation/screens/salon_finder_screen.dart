
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/presentation/widgets/app_gradient_appbar.dart';
import '../bloc/salon_finder_bloc.dart';
import '../bloc/salon_finder_event.dart';
import '../bloc/salon_finder_state.dart';
import '../widgets/salon_card.dart';

class SalonFinderScreen extends StatelessWidget {
  const SalonFinderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SalonFinderBloc()..add(LoadSalons()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('Salon Finder', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: BlocBuilder<SalonFinderBloc, SalonFinderState>(
          builder: (context, state) {
            if (state is SalonFinderLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SalonFinderError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is SalonFinderEmpty) {
              return const Center(child: Text('No salons available.'));
            } else if (state is SalonFinderLoaded) {
              final salons = state.salons;
              return ListView.builder(
                itemCount: salons.length,
                itemBuilder: (context, index) {
                  return SalonCard(salon: salons[index]);
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}



