


import 'package:hairvana/%20features/salon/domain/stylist.dart';

class Salon {
  final String name;
  final String imageUrl;
  final double rating;
  final int reviews;
  final String distance;
  final String priceRange;
  final List<String> tags;
  final String hours;
  final String address;
  final String phone;
  final List<Stylist> stylists;

  Salon({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.priceRange,
    required this.tags,
    required this.hours,
    required this.address,
    required this.phone,
    required this.stylists,
  });
}
