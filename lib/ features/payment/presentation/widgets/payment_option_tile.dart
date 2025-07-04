import 'package:flutter/material.dart';


class PaymentOptionTile extends StatelessWidget {
  final int value;
  final int selected;
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final ValueChanged<int> onChanged;

  const PaymentOptionTile({
    required this.value,
    required this.selected,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: RadioListTile<int>(
        value: value,
        groupValue: selected,
        onChanged: (val) => onChanged(val!),
        title: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}
