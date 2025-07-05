
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/fake_data/styles_items.dart';
import '../bloc/booking_bloc.dart';
import '../bloc/booking_event.dart';
import '../bloc/booking_state.dart';
import '../widgets/booking_app_bar.dart';
import '../widgets/booking_info_card.dart';
import '../widgets/booking_date_selector.dart';
import '../widgets/booking_time_selector.dart';
import '../widgets/booking_continue_button.dart';
import '../../../payment/presentation/screens/payment_screen.dart';
import '../../../salon/domain/salon.dart';
import '../../../salon/domain/stylist.dart';
import '../../../home/presentation/domain/entities/style_item.dart';
import '../../domain/entities/booking.dart';

class BookingScreen extends StatelessWidget {
  final StyleItem styleItem;
  final Salon salon;
  final Stylist stylist;

  const BookingScreen({
    Key? key,
    required this.styleItem,
    required this.salon,
    required this.stylist,
  }) : super(key: key);

  void _goToPayment(BuildContext context, DateTime date, TimeOfDay time) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          styleItem: styleItem,
          price: 120.0,
          serviceFee: 5.0,
          tax: 10.0,
          date: date,
          time: time,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(),
      child: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state.success) {
            _goToPayment(context, state.selectedDate, state.selectedTime);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: BookingAppBar(onBack: () => Navigator.of(context).pop()),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Book Your Appointment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  const SizedBox(height: 16),
                  BookingInfoCard(salon: salon, stylist: stylist, styleItem: styleItem),
                  const SizedBox(height: 18),
                  BookingDateSelector(
                    selectedDate: state.selectedDate,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: state.selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        context.read<BookingBloc>().add(BookingDateSelected(picked));
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  BookingTimeSelector(
                    selectedTime: state.selectedTime,
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: state.selectedTime,
                      );
                      if (picked != null) {
                        context.read<BookingBloc>().add(BookingTimeSelected(picked));
                      }
                    },
                  ),
                  const Spacer(),
                  BookingContinueButton(
                    onPressed: () {
                      final booking = Booking(
                        salon: salon.name,
                        stylist: stylist.name,
                        style: styleItem.name,
                        date: state.selectedDate,
                        time: state.selectedTime,
                      );
                      context.read<BookingBloc>().add(BookingConfirmed(booking));
                    },
                  ),
                  if (state.isLoading)
                    const Center(child: CircularProgressIndicator()),
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

