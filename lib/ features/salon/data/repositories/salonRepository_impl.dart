// lib/features/salon/data/repositories/fake_salon_repository.dart
import '../../domain/repository/salonRepository.dart';
import '../../domain/salon.dart';
import '../../domain/stylist.dart';


class FakeSalonRepository implements SalonRepository {
  @override
  Future<List<Salon>> getSalons() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    return [
      Salon(
        name: 'Glow Beauty Lounge',
        imageUrl: 'https://images.pexels.com/photos/3992875/pexels-photo-3992875.jpeg',
        rating: 4.8,
        reviews: 120,
        distance: '1.2 km',
        priceRange: '\$\$',
        tags: ['Popular', 'Luxury'],
        hours: '10 AM - 8 PM',
        address: '123 Main Street, Cityville',
        phone: '+1 555-1234',
        stylists: [
          Stylist(name: 'Ava Johnson',specialties: [],rating: 4.9, imageUrl: '',),
        ],
      ),
      Salon(
        name: 'Urban Chic Salon',
        imageUrl: 'https://images.pexels.com/photos/853427/pexels-photo-853427.jpeg',
        rating: 4.7,
        reviews: 105,
        distance: '3.0 km',
        priceRange: '\$\$\$',
        tags: ['Premium', 'Spa'],
        hours: '11 AM - 9 PM',
        address: '789 Glam Rd, Cosmopolis',
        phone: '+1 555-8765',
        stylists: [
          Stylist(name: 'Olivia Taylor', rating: 4.7,imageUrl: '',specialties: []),
        ],
      ),
    ];
  }
}
