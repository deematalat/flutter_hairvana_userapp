import 'package:flutter/material.dart';
import '../../../home/presentation/domain/entities/style_item.dart';
import '../../domain/salon.dart';
import '../../domain/stylist.dart';
import '../screens/salon_details_screen.dart';
import '../../../booking/presentation/screens/booking_start_screen.dart';

class SalonCard extends StatelessWidget {
  final Salon salon;

  const SalonCard({Key? key, required this.salon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 16, vertical: isSmall ? 6 : 10),
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
              height: isSmall ? 110 : 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Info
          Padding(
            padding: EdgeInsets.all(isSmall ? 8 : 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(salon.name,
                      style: TextStyle(fontSize: isSmall ? 15 : 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 6),

                // Rating and Distance
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber[600], size: isSmall ? 15 : 18),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text('${salon.rating} (${salon.reviews} reviews)',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: isSmall ? 12 : 14)),
                    ),
                    const Spacer(),
                    Icon(Icons.location_on_outlined, size: isSmall ? 15 : 18, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(salon.distance,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: isSmall ? 12 : 14)),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Tags
                Wrap(
                  spacing: 6,
                  children: salon.tags
                      .map((tag) => Chip(
                            label: Text(tag, style: TextStyle(fontSize: isSmall ? 10 : 12)),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SalonDetailsScreen(salon: salon),
                          ),
                        );
                      },
                      icon: Icon(Icons.design_services_outlined, size: isSmall ? 16 : 20),
                      label: Text('Services', style: TextStyle(fontSize: isSmall ? 12 : 14)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: const BorderSide(color: Colors.grey),
                        padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 16, vertical: isSmall ? 6 : 10),
                      ),
                    ),

                    // Book
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookingStartScreen(salon: salon),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFa78bfa), // purple
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 16, vertical: isSmall ? 6 : 10),
                      ),
                      child: Text('Book', style: TextStyle(fontSize: isSmall ? 12 : 14)),
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

