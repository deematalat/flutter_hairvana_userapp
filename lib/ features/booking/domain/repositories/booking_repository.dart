import '../entities/booking.dart';

abstract class BookingRepository {
  static final List<Booking> bookings = [];
  void addBooking(Booking booking);
  List<Booking> getBookings();
}
