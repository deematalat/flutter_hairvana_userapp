
import 'package:flutter/material.dart';
import '../../../home/presentation/widgets/app_gradient_appbar.dart';

import '../../data/repositories/salonRepository_impl.dart';
import '../../domain/salon.dart';
import '../widgets/salon_card.dart';


class SalonFinderScreen extends StatefulWidget {
  const SalonFinderScreen({Key? key}) : super(key: key);

  @override
  State<SalonFinderScreen> createState() => _SalonFinderScreenState();
}

class _SalonFinderScreenState extends State<SalonFinderScreen> {
  late Future<List<Salon>> _futureSalons;

  @override
  void initState() {
    super.initState();
    _futureSalons = FakeSalonRepository().getSalons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
      body: FutureBuilder<List<Salon>>(
        future: _futureSalons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No salons available.'));
          }

          final salons = snapshot.data!;
          return ListView.builder(
            itemCount: salons.length,
            itemBuilder: (context, index) {
              return SalonCard(salon: salons[index]);
            },
          );
        },
      ),
    );
  }
}



