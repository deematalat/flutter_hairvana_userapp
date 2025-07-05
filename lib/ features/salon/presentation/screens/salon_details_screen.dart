import 'package:flutter/material.dart';
import '../../../booking/presentation/screens/booking_start_screen.dart';
import '../../domain/salon.dart';

class SalonDetailsScreen extends StatelessWidget {
  final Salon salon;
  const SalonDetailsScreen({Key? key, required this.salon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Salon Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Salon Info Card
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            salon.imageUrl,
                            width: isSmall ? 60 : 90,
                            height: isSmall ? 60 : 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(salon.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.grey[500], size: 16),
                                  const SizedBox(width: 4),
                                  Expanded(child: Text(salon.address, style: const TextStyle(fontSize: 13, color: Colors.grey), overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber[600], size: 16),
                                  const SizedBox(width: 2),
                                  Text(salon.rating.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Services & Pricing
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: const Text(
                  'Services & Pricing',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  children: [
                    _ServiceCard(title: 'Cuts', price: ' 45-85', duration: '45-60 min', isSmall: isSmall),
                    _ServiceCard(title: 'Color', price: ' 45-85', duration: '45-60 min', isSmall: isSmall),
                    _ServiceCard(title: 'Styling', price: ' 45-85', duration: '45-60 min', isSmall: isSmall),
                    _ServiceCard(title: 'Treatments', price: ' 45-85', duration: '45-60 min', isSmall: isSmall),
                  ],
                ),
              ),
              // Stylists
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: const Text(
                  'Our Stylists',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SizedBox(
                  height: isSmall ? 120 : 160,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: salon.stylists.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final stylist = salon.stylists[index];
                      return _StylistCard(
                        name: stylist.name,
                        imageUrl: stylist.imageUrl,
                        rating: stylist.rating,
                        specialties: stylist.specialties,
                        isSmall: isSmall,
                      );
                    },
                  ),
                ),
              ),
              // Reviews
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: const Text(
                  'Recent Reviews',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  children: const [
                    _ReviewCard(
                      initials: 'S',
                      name: 'Sarah M.',
                      rating: 5,
                      date: '2 days ago',
                      review: 'Amazing service! Love my new haircut.',
                    ),
                    _ReviewCard(
                      initials: 'M',
                      name: 'Mike R.',
                      rating: 5,
                      date: '1 week ago',
                      review: 'Great atmosphere and skilled stylists.',
                    ),
                    _ReviewCard(
                      initials: 'E',
                      name: 'Emma L.',
                      rating: 5,
                      date: '2 weeks ago',
                      review: 'Best salon experience I\'ve had!',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Call salon
                },
                icon: const Icon(Icons.phone, color: Color(0xFFf472b6)),
                label: const Text('Call Now', style: TextStyle(color: Color(0xFFf472b6))),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFf472b6)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingStartScreen(salon: salon),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  backgroundColor: const Color(0xFFa78bfa),
                  foregroundColor: Colors.white,
                ).copyWith(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                    return states.contains(MaterialState.pressed)
                        ? const Color(0xFFf472b6)
                        : const Color(0xFFa78bfa);
                  }),
                ),
                child: const Text('Book Appointment', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String price;
  final String duration;
  final bool isSmall;
  const _ServiceCard({required this.title, required this.price, required this.duration, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      child: ListTile(
        leading: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Icon(Icons.content_cut, color: Colors.white, size: isSmall ? 18 : 24),
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        subtitle: const Text('Professional styling service'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(price, style: const TextStyle(color: Color(0xFFa78bfa), fontWeight: FontWeight.bold, fontSize: 16)),
            Text(duration, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _StylistCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double rating;
  final List<String> specialties;
  final bool isSmall;
  const _StylistCard({required this.name, required this.imageUrl, required this.rating, required this.specialties, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Container(
        width: isSmall ? 100 : 140,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: isSmall ? 20 : 28,
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber[600], size: 16),
                const SizedBox(width: 2),
                Text(rating.toStringAsFixed(1)),
              ],
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 4,
              children: specialties.map((s) => Chip(
                label: Text(s, style: TextStyle(fontSize: isSmall ? 10 : 12)),
                backgroundColor: const Color(0xFFf3e8ff),
                labelStyle: const TextStyle(color: Color(0xFFa78bfa)),
                padding: EdgeInsets.zero,
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String initials;
  final String name;
  final int rating;
  final String date;
  final String review;
  const _ReviewCard({required this.initials, required this.name, required this.rating, required this.date, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFf3e8ff),
              child: Text(initials, style: const TextStyle(color: Color(0xFFa78bfa), fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(child: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold))),
                      const SizedBox(width: 8),
                      Row(
                        children: List.generate(5, (i) => Icon(
                          Icons.star,
                          color: i < rating ? Colors.amber[600] : Colors.grey[300],
                          size: 16,
                        )),
                      ),
                      const SizedBox(width: 8),
                      Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(review),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 