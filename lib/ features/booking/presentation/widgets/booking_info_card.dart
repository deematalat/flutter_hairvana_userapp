import 'package:flutter/material.dart';
import '../../../salon/domain/salon.dart';
import '../../../salon/domain/stylist.dart';
import '../../../home/presentation/domain/entities/style_item.dart';

class BookingInfoCard extends StatelessWidget {
  final Salon salon;
  final Stylist stylist;
  final StyleItem styleItem;
  const BookingInfoCard({required this.salon, required this.stylist, required this.styleItem, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow(Icons.location_on, 'Salon:', salon.name, color: const Color(0xFFa78bfa)),
            const SizedBox(height: 10),
            _infoRow(Icons.person, 'Stylist:', stylist.name, color: const Color(0xFFf472b6)),
            const SizedBox(height: 10),
            _infoRow(Icons.content_cut, 'Style:', styleItem.name, color: const Color(0xFF60a5fa)),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value, {required Color color}) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(width: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
} 