import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class AddBooking {
  final BookingRepository repository;

  AddBooking(this.repository);

  void call(Booking booking) {
    repository.addBooking(booking);
  }
}
