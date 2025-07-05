import 'package:flutter/material.dart';

class FilterCards extends StatelessWidget {
  const FilterCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filters = ['Curtain Bangs', 'Beach Waves', 'Pixie Cut'];
    return Positioned(
      bottom: 180,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: filters.map((f) => _FilterCard(label: f)).toList(),
      ),
    );
  }
}

class _FilterCard extends StatelessWidget {
  final String label;
  const _FilterCard({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Center(
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
} 