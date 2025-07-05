import 'package:flutter/material.dart';

class PaymentTypeSelector extends StatelessWidget {
  final int? selectedType;
  final ValueChanged<int> onSelected;
  const PaymentTypeSelector({required this.selectedType, required this.onSelected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onSelected(0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: selectedType == 0 ? const Color(0xFFede9fe) : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: const [
                    Icon(Icons.credit_card, color: Color(0xFF60a5fa), size: 36),
                    SizedBox(height: 8),
                    Text('Card', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => onSelected(1),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: selectedType == 1 ? const Color(0xFFede9fe) : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: const [
                    Icon(Icons.language, color: Color(0xFF60a5fa), size: 36),
                    SizedBox(height: 8),
                    Text('Crypto', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
} 