
import 'package:flutter/material.dart';
import '../../../home/data/fake_data/styles_items.dart';
import '../../../home/presentation/domain/entities/style_item.dart';
import '../../../salon/domain/salon.dart';
import '../../../salon/domain/stylist.dart';
import 'booking_screen.dart';

class BookingStartScreen extends StatefulWidget {
  final Salon salon;
  const BookingStartScreen({Key? key, required this.salon}) : super(key: key);

  @override
  State<BookingStartScreen> createState() => _BookingStartScreenState();
}

class _BookingStartScreenState extends State<BookingStartScreen> {
  Stylist? selectedStylist;
  StyleItem? selectedStyle;

  @override
  Widget build(BuildContext context) {
    final List<StyleItem> styles = styleItems;
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
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
                  'Book Appointment',
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Salon Info
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.salon.imageUrl,
                          width: isSmall ? 50 : 70,
                          height: isSmall ? 50 : 70,
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
                              child: Text(widget.salon.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.grey[500], size: 16),
                                const SizedBox(width: 4),
                                Expanded(child: Text(widget.salon.address, style: const TextStyle(fontSize: 13, color: Colors.grey), overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber[600], size: 16),
                                const SizedBox(width: 2),
                                Text(widget.salon.rating.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text('Choose a Stylist', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              SizedBox(
                height: isSmall ? 100 : 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.salon.stylists.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final stylist = widget.salon.stylists[index];
                    final isSelected = stylist == selectedStylist;
                    return ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isSmall ? 80 : 100),
                      child: GestureDetector(
                        onTap: () => setState(() => selectedStylist = stylist),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFa78bfa) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: isSelected ? const Color(0xFFa78bfa) : Colors.grey.shade300, width: 2),
                            boxShadow: isSelected ? [BoxShadow(color: Colors.purple.withOpacity(0.08), blurRadius: 8)] : [],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(stylist.imageUrl),
                                radius: isSmall ? 20 : 28,
                              ),
                              const SizedBox(height: 8),
                              Flexible(
                                child: Text(stylist.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star, color: Colors.amber[600], size: 14),
                                  const SizedBox(width: 2),
                                  Text(stylist.rating.toStringAsFixed(1), style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.black)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              const Text('Choose a Style', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 10),
              SizedBox(
                height: isSmall ? 130 : 160,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: styles.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final style = styles[index];
                    final isSelected = style == selectedStyle;
                    return ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isSmall ? 100 : 120),
                      child: GestureDetector(
                        onTap: () => setState(() => selectedStyle = style),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.all(isSmall ? 8 : 10),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFf472b6) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: isSelected ? const Color(0xFFf472b6) : Colors.grey.shade300, width: 2),
                            boxShadow: isSelected ? [BoxShadow(color: Colors.pink.withOpacity(0.08), blurRadius: 8)] : [],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  style.imageUrl, 
                                  width: isSmall ? 45 : 65, 
                                  height: isSmall ? 45 : 65, 
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: isSmall ? 45 : 65,
                                    height: isSmall ? 45 : 65,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(Icons.image, color: Colors.grey[600], size: isSmall ? 20 : 24),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Flexible(
                                child: Text(
                                  style.name, 
                                  maxLines: 2, 
                                  overflow: TextOverflow.ellipsis, 
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, 
                                    fontSize: isSmall ? 11 : 13,
                                    color: isSelected ? Colors.white : Colors.black
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 4,
                                runSpacing: 2,
                                children: [
                                  if (style.trending)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFa78bfa),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        'Trending', 
                                        style: TextStyle(
                                          color: Colors.white, 
                                          fontSize: isSmall ? 8 : 9,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFf3e8ff),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      style.difficulty, 
                                      style: TextStyle(
                                        color: const Color(0xFFa78bfa), 
                                        fontSize: isSmall ? 8 : 9,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: ElevatedButton(
                  onPressed: selectedStylist != null && selectedStyle != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookingScreen(
                                salon: widget.salon,
                                stylist: selectedStylist!,
                                styleItem: selectedStyle!,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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
                  child: const Text('Continue', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}