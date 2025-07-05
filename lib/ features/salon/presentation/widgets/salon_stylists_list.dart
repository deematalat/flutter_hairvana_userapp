import 'package:flutter/material.dart';
import '../../domain/stylist.dart';

class SalonStylistsList extends StatelessWidget {
  final List<Stylist> stylists;
  const SalonStylistsList({Key? key, required this.stylists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Stylists', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        ...stylists.map((stylist) => ListTile(title: Text(stylist.name))).toList(),
      ],
    );
  }
} 