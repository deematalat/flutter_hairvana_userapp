import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../home/presentation/domain/entities/style_item.dart';
import '../widgets/payment_option_tile.dart';
import '../widgets/payment_summery_card.dart';
import 'payment_details_screen.dart';

class PaymentScreen extends StatefulWidget {
  final StyleItem styleItem;
  final double serviceFee;
  final double tax;
  final double price;
  final DateTime date;
  final TimeOfDay time;

  const PaymentScreen({
    Key? key,
    required this.styleItem,
    this.serviceFee = 5.0,
    this.tax = 10.0,
    this.price = 120.0,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedOption = 0; // 0: Pay Now, 1: Pay at Salon

  double get total => widget.price + widget.serviceFee + widget.tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose Payment Method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(height: 16),

            PaymentSummaryCard(
              styleItem: widget.styleItem,
              price: widget.price,
              serviceFee: widget.serviceFee,
              tax: widget.tax,
              date: widget.date,
              time: widget.time,
              total: total,
            ),

            const SizedBox(height: 24),
            const Text('Payment Options', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            PaymentOptionTile(
              value: 0,
              selected: selectedOption,
              icon: Icons.credit_card,
              color: const Color(0xFF60a5fa),
              title: 'Pay Now (Online)',
              subtitle: 'Credit/Debit Card or Crypto Wallet',
              onChanged: (val) => setState(() => selectedOption = val),
            ),

            const SizedBox(height: 8),
            PaymentOptionTile(
              value: 1,
              selected: selectedOption,
              icon: Icons.attach_money,
              color: Colors.green,
              title: 'Pay at Salon (Cash)',
              subtitle: 'Confirm now, pay in person',
              onChanged: (val) => setState(() => selectedOption = val),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFa78bfa),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Continue to Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleContinue() async {
    if (selectedOption == 0) {
      // Pay now
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PaymentDetailsScreen(
            total: total,
            date: widget.date,
            time: widget.time,
            stylist: 'Sarah Chen',
            salon: 'The Hair Lab',
            style: widget.styleItem.name,
          ),
        ),
      );
    } else {
      // Pay at salon – Show confirmation then navigate home
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check_circle, color: Color(0xFFa78bfa), size: 60),
              SizedBox(height: 16),
              Text('Thank you!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              SizedBox(height: 8),
              Text('Your booking is confirmed. Please pay at the salon.', textAlign: TextAlign.center),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => MainNavigation(initialIndex: 0)),
              (route) => false,
        );
      });
    }
  }
}
