import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';


class BookingRepositoryImpl implements BookingRepository {
  static final List<Booking> _bookings = [];

  @override
  void addBooking(Booking booking) {
    _bookings.add(booking);
  }

  @override
  List<Booking> getBookings() {
    return _bookings;
  }
}
