import 'package:flutter/material.dart';

class SalonDetailsBottomBar extends StatelessWidget {
  final VoidCallback onBookNow;
  const SalonDetailsBottomBar({Key? key, required this.onBookNow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onBookNow,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Book Now', style: TextStyle(fontSize: 18)),
      ),
    );
  }
} 