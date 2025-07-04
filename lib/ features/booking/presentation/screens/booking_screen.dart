
import 'package:flutter/material.dart';
import '../../../payment/presentation/screens/payment_screen.dart';
import '../../../salon/domain/salon.dart';
import '../../../salon/domain/stylist.dart';
import '../../../home/presentation/domain/entities/style_item.dart';
import '../../domain/entities/booking.dart';
import '../../domain/usecases/add_booking.dart';
import '../../data/repositories/booking_repository_impl.dart';


class BookingScreen extends StatefulWidget {
  final StyleItem styleItem;
  final Salon salon;
  final Stylist stylist;

  const BookingScreen({
    Key? key,
    required this.styleItem,
    required this.salon,
    required this.stylist,
  }) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final AddBooking _addBookingUseCase = AddBooking(BookingRepositoryImpl());

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 14, minute: 0);

  void _onConfirmBooking() {
    final booking = Booking(
      salon: widget.salon.name,
      stylist: widget.stylist.name,
      style: widget.styleItem.name,
      date: selectedDate,
      time: selectedTime,
    );
    _addBookingUseCase.call(booking);
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  void _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) setState(() => selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Book Your Appointment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(height: 16),
            _buildInfoCard(),
            const SizedBox(height: 18),
            _buildDateSelector(),
            const SizedBox(height: 12),
            _buildTimeSelector(),
            const Spacer(),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text('Book Appointment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow(Icons.location_on, 'Salon:', widget.salon.name, color: const Color(0xFFa78bfa)),
            const SizedBox(height: 10),
            _infoRow(Icons.person, 'Stylist:', widget.stylist.name, color: const Color(0xFFf472b6)),
            const SizedBox(height: 10),
            _infoRow(Icons.content_cut, 'Style:', widget.styleItem.name, color: const Color(0xFF60a5fa)),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value, {required Color color}) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.grey)),
        const SizedBox(width: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildDateSelector() {
    return GestureDetector(
      onTap: _selectDate,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.grey),
              const SizedBox(width: 12),
              Text('Today, ${selectedDate.month}/${selectedDate.day}', style: const TextStyle(fontSize: 16)),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    return GestureDetector(
      onTap: _selectTime,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              const Icon(Icons.access_time, color: Colors.grey),
              const SizedBox(width: 12),
              Text(selectedTime.format(context), style: const TextStyle(fontSize: 16)),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _onConfirmBooking();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PaymentScreen(
                styleItem: widget.styleItem,
                price: 120.0,
                serviceFee: 5.0,
                tax: 10.0,
                date: selectedDate,
                time: selectedTime,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
          backgroundColor: const Color(0xFFa78bfa),
          foregroundColor: Colors.white,
        ),
        child: const Text('Continue to Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

