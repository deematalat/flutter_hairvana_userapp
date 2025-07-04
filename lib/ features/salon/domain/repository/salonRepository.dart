
import '../salon.dart';

abstract class SalonRepository {
  Future<List<Salon>> getSalons();
}
