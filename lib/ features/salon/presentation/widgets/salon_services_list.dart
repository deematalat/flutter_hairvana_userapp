import 'package:flutter/material.dart';

class SalonServicesList extends StatelessWidget {
  final List<String> services;
  const SalonServicesList({Key? key, required this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Services', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        ...services.map((service) => ListTile(title: Text(service))).toList(),
      ],
    );
  }
} 