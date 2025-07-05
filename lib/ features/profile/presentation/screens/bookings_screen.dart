import 'package:flutter/material.dart';
import '../../../booking/data/repositories/booking_repository_impl.dart';
import '../../../booking/domain/usecases/get_bookings.dart';

class BookingsScreen extends StatelessWidget {

  final GetBookings _getBookings = GetBookings(BookingRepositoryImpl());
  BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookings = _getBookings.call();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: const Color(0xFF60a5fa),
      ),
      body: bookings.isEmpty
          ? const Center(child: Text('No bookings yet.'))
          : ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final b = bookings[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.calendar_today, color: Color(0xFFa78bfa)),
              title: Text('${b.salon} - ${b.stylist}'),
              subtitle: Text(
                '${b.style}\n${b.date.month}/${b.date.day}/${b.date.year} at ${b.time.format(context)}',
              ),
            ),
          );
        },
      ),
    );
  }
}
