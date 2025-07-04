import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import'../../../../core/styles/text_styles.dart';
import '../../../home/presentation/widgets/app_gradient_appbar.dart';
import '../../../booking/presentation/providers/app_state.dart';
import '../../../booking/presentation/screens/bookings_screen.dart';
import 'fav_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String subtitle;
  final int stylesTried;
  final List<Activity> activities;

  const ProfileScreen({
    Key? key,
    this.name = 'Alex Johnson',
    this.subtitle = 'Hair enthusiast since 2023',
    this.stylesTried = 12,
    this.activities = const [
      Activity(icon: FontAwesomeIcons.camera, title: 'Tried AR with Curtain Bangs', subtitle: '2 hours ago'),
      Activity(icon: FontAwesomeIcons.heart, title: 'Saved Beach Waves style', subtitle: '1 day ago'),
      Activity(icon: FontAwesomeIcons.calendar, title: 'Booked appointment with Sarah', subtitle: '3 days ago'),
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final savedStyles = appState.favorites.length;
    final salonVisits = appState.bookings.length;
    final size = MediaQuery.of(context).size;
    final double horizontalPadding = size.width * 0.06;
    final double avatarSize = size.width * 0.22 > 110 ? 110 : size.width * 0.22;
    final double statCardWidth = (size.width - 2 * horizontalPadding - 32) / 3;
    final double actionCardWidth = (size.width - 2 * horizontalPadding - 18) / 2;
    final String initial = name.isNotEmpty ? name[0].toUpperCase() : 'A';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                const AppGradientAppBar(
                  title: 'My Profile',
                  subtitle: '',
                  showProfileIcon: false,
                ),
                Positioned(
                  top: 44,
                  left: 16,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1C4E9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  initial,
                  style: AppTextStyles.largeTitle(color: Colors.white, fontSize: avatarSize * 0.45),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(name, style: AppTextStyles.title(fontSize: 28)),
            const SizedBox(height: 6),
            Text(subtitle, style: AppTextStyles.body(color: Colors.black54, fontSize: 16)),
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatCard(
                    value: stylesTried.toString(),
                    label: 'Styles Tried',
                    color: const Color(0xFFa21caf),
                    width: statCardWidth,
                  ),
                  _StatCard(
                    value: salonVisits.toString(),
                    label: 'Salon Visits',
                    color: const Color(0xFFec4899),
                    width: statCardWidth,
                  ),
                  _StatCard(
                    value: savedStyles.toString(),
                    label: 'Saved Styles',
                    color: const Color(0xFF60a5fa),
                    width: statCardWidth,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: [
                  _ProfileActionCard(
                    icon: FontAwesomeIcons.heart,
                    title: 'Favorites',
                    subtitle: '$savedStyles saved styles',
                    gradient: const LinearGradient(colors: [Color(0xFFa78bfa), Color(0xFFf472b6)]),
                    width: actionCardWidth,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                    ),
                  ),
                  const SizedBox(width: 18),
                  _ProfileActionCard(
                    icon: FontAwesomeIcons.calendar,
                    title: 'Bookings',
                    subtitle: 'Your appointments',
                    gradient: const LinearGradient(colors: [Color(0xFF60a5fa), Color(0xFF818cf8)]),
                    width: actionCardWidth,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) =>  BookingsScreen()),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Recent Activity', style: AppTextStyles.title(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: activities
                    .map((a) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ActivityCard(icon: a.icon, title: a.title, subtitle: a.subtitle),
                ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class Activity {
  final IconData icon;
  final String title;
  final String subtitle;

  const Activity({required this.icon, required this.title, required this.subtitle});
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final double width;

  const _StatCard({
    Key? key,
    required this.value,
    required this.label,
    required this.color,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.title(color: color, fontSize: 22)),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.body(color: Colors.black54, fontSize: 14)),
        ],
      ),
    );
  }
}

class _ProfileActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final LinearGradient gradient;
  final double width;
  final VoidCallback? onTap;

  const _ProfileActionCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.width,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.10),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 10),
            Text(title, style: AppTextStyles.button(fontSize: 18)),
            const SizedBox(height: 4),
            Text(subtitle, style: AppTextStyles.body(color: Colors.white70, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ActivityCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(icon, color: Colors.purple, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.title(fontSize: 16)),
              Text(subtitle, style: AppTextStyles.body(color: Colors.black54, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
