import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/payment_details_bloc.dart';
import '../bloc/payment_details_event.dart';
import '../bloc/payment_details_state.dart';
import '../widgets/payment_details_app_bar.dart';
import '../widgets/payment_type_selector.dart';
import '../widgets/payment_card_form.dart';
import '../widgets/payment_crypto_wallet_section.dart';
import '../widgets/payment_confirm_button.dart';
import '../widgets/payment_confirmation_dialog.dart';
import '../../../booking/domain/entities/booking.dart';
import '../../../booking/domain/repositories/booking_repository.dart';
import '../widgets/payment_failure.dart';

class PaymentDetailsScreen extends StatefulWidget {
  final double total;
  final DateTime date;
  final TimeOfDay time;
  final String stylist;
  final String salon;
  final String style;
  const PaymentDetailsScreen({Key? key, required this.total, required this.date, required this.time, required this.stylist, required this.salon, required this.style}) : super(key: key);

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentDetailsBloc(),
      child: BlocConsumer<PaymentDetailsBloc, PaymentDetailsState>(
        listener: (context, state) {
          if (state.success) {
            BookingRepository.bookings.add(Booking(
              salon: widget.salon,
              stylist: widget.stylist,
              style: widget.style,
              date: widget.date,
              time: widget.time,
            ));
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => PaymentConfirmationDialog(
                stylist: widget.stylist,
                salon: widget.salon,
                style: widget.style,
                date: widget.date,
                time: widget.time,
                onClose: () => Navigator.of(context).popUntil((route) => route.isFirst),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: PaymentDetailsAppBar(onBack: () => Navigator.of(context).pop()),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text('Payment Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  const SizedBox(height: 24),
                  Text('Date:  ${widget.date.month}/${widget.date.day}/${widget.date.year}'),
                  Text('Time:  ${widget.time.format(context)}'),
                  const SizedBox(height: 24),
                  const Text('Choose Payment Type', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  PaymentTypeSelector(
                    selectedType: state.selectedType,
                    onSelected: (type) => context.read<PaymentDetailsBloc>().add(PaymentTypeSelected(type)),
                  ),
                  const SizedBox(height: 24),
                  if (state.selectedType == 0)
                    PaymentCardForm(
                      cardNumberController: _cardNumberController,
                      expiryController: _expiryController,
                      cvvController: _cvvController,
                      saveCard: state.saveCard,
                      onSaveCardChanged: (val) => context.read<PaymentDetailsBloc>().add(
                        PaymentCardFieldChanged(
                          cardNumber: _cardNumberController.text,
                          expiry: _expiryController.text,
                          cvv: _cvvController.text,
                          saveCard: val ?? false,
                        ),
                      ),
                      formKey: _formKey,
                    )
                  else if (state.selectedType == 1)
                    const PaymentCryptoWalletSection(),
                  const Spacer(),
                  PaymentConfirmButton(
                    enabled: state.selectedType != null && !state.isProcessing,
                    isProcessing: state.isProcessing,
                    label: 'Confirm Payment (\$${widget.total.toStringAsFixed(2)})',
                    onPressed: () {
                      if (state.selectedType == 0) {
                        // Validate form and show errors if any
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<PaymentDetailsBloc>().add(PaymentDetailsSubmitted());
                        } else {
                          // Show a snackbar to inform user about validation errors
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all required fields correctly'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      } else if (state.selectedType == 1) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => PaymentFailureScreen()),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
















