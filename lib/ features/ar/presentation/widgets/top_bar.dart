import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final VoidCallback onClose;
  const TopBar({required this.onClose, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      child: GestureDetector(
        onTap: onClose,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close, color: Colors.white, size: 28),
        ),
      ),
    );
  }
} 