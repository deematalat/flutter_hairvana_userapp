

import 'package:flutter/material.dart';
import '../../../home/presentation/domain/entities/style_item.dart';


class PaymentSummaryCard extends StatelessWidget {
   final StyleItem styleItem;
   final double price;
   final double serviceFee;
   final double tax;
   final double total;
   final DateTime date;
   final TimeOfDay time;

  const PaymentSummaryCard({
    required this.styleItem,
    required this.price,
    required this.serviceFee,
    required this.tax,
    required this.total,
    required this.date,
    required this.time,
  });

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
            const Text('Order Summary', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _summaryRow(styleItem.name, '\$${price.toStringAsFixed(2)}'),
            _summaryRow('Service Fee', '\$${serviceFee.toStringAsFixed(2)}'),
            _summaryRow('Tax', '\$${tax.toStringAsFixed(2)}'),
            _summaryRow('Date', '${date.month}/${date.day}/${date.year}'),
            _summaryRow('Time', time.format(context)),
            const Divider(height: 20),
            _summaryRow('Total', '\$${total.toStringAsFixed(2)}', bold: true, highlight: true),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false, bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: highlight ? const Color(0xFFa78bfa) : null,
              fontSize: highlight ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
