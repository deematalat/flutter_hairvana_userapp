import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class GetBookings {
  final BookingRepository repository;

  GetBookings(this.repository);

  List<Booking> call() {
    return repository.getBookings();
  }
}
