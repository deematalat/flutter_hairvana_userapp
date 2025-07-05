import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';
import '../../../home/presentation/domain/entities/style_item.dart';
import '../widgets/payment_option_tile.dart';
import '../widgets/payment_summery_card.dart';
import 'payment_details_screen.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_event.dart';
import '../bloc/payment_state.dart';
import '../widgets/payment_app_bar.dart';
import '../widgets/payment_continue_button.dart';

class PaymentScreen extends StatelessWidget {
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

  double getTotal() => price + serviceFee + tax;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentBloc(),
      child: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) async {
          if (state.success) {
            if (state.selectedOption == 0) {
              // Pay now
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PaymentDetailsScreen(
                    total: getTotal(),
                    date: date,
                    time: time,
                    stylist: 'Sarah Chen',
                    salon: 'The Hair Lab',
                    style: styleItem.name,
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
        },
        builder: (context, state) {
          return Scaffold(
            appBar: PaymentAppBar(onBack: () => Navigator.of(context).pop()),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Choose Payment Method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  const SizedBox(height: 16),
                  PaymentSummaryCard(
                    styleItem: styleItem,
                    price: price,
                    serviceFee: serviceFee,
                    tax: tax,
                    date: date,
                    time: time,
                    total: getTotal(),
                  ),
                  const SizedBox(height: 24),
                  const Text('Payment Options', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  PaymentOptionTile(
                    value: 0,
                    selected: state.selectedOption,
                    icon: Icons.credit_card,
                    color: const Color(0xFF60a5fa),
                    title: 'Pay Now (Online)',
                    subtitle: 'Credit/Debit Card or Crypto Wallet',
                    onChanged: (val) => context.read<PaymentBloc>().add(PaymentOptionSelected(val)),
                  ),
                  const SizedBox(height: 8),
                  PaymentOptionTile(
                    value: 1,
                    selected: state.selectedOption,
                    icon: Icons.attach_money,
                    color: Colors.green,
                    title: 'Pay at Salon (Cash)',
                    subtitle: 'Confirm now, pay in person',
                    onChanged: (val) => context.read<PaymentBloc>().add(PaymentOptionSelected(val)),
                  ),
                  const SizedBox(height: 32),
                  PaymentContinueButton(
                    onPressed: () => context.read<PaymentBloc>().add(PaymentContinuePressed()),
                    isLoading: state.isLoading,
                  ),
                  if (state.error != null)
                    Center(child: Text(state.error!, style: const TextStyle(color: Colors.red))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
