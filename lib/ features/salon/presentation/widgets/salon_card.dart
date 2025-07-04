import 'package:flutter/material.dart';
import '../../../booking/presentation/screens/booking_screen.dart';
import '../../../home/data/fake_data/styles_items.dart';
import '../../../home/presentation/domain/entities/style_item.dart';
import '../../domain/salon.dart';
import '../../domain/stylist.dart';

class SalonCard extends StatelessWidget {
  final Salon salon;

  const SalonCard({Key? key, required this.salon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stylist selectedStylist = salon.stylists.first;
    final StyleItem selectedStyleItem = StyleItem(
      name: 'Haircut',
    imageUrl: 'assets/images/haircut.png',
      trending: true, difficulty:'hard', tag: '' , rating: 4, type: 'cut',

    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              salon.imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(salon.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),

                // Rating and Distance
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber[600], size: 18),
                    const SizedBox(width: 4),
                    Text('${salon.rating} (${salon.reviews} reviews)'),
                    const Spacer(),
                    Icon(Icons.location_on_outlined, size: 18, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(salon.distance),
                  ],
                ),

                const SizedBox(height: 8),

                // Tags
                Wrap(
                  spacing: 6,
                  children: salon.tags
                      .map((tag) => Chip(
                    label: Text(tag),
                    backgroundColor: const Color(0xFFf3f4f6),
                  ))
                      .toList(),
                ),

                const SizedBox(height: 12),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Services
                    OutlinedButton.icon(
                      onPressed: () {
                        // Show services dialog or screen
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Services'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('- Haircut'),
                                const Text('- Styling'),
                                const Text('- Coloring'),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.design_services_outlined),
                      label: const Text('Services'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),

                    // Book
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookingScreen(
                              salon: salon,
                              stylist: selectedStylist,
                              styleItem: selectedStyleItem,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFa78bfa), // purple
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Book'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

