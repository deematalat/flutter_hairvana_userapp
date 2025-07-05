import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../home/presentation/widgets/app_gradient_appbar.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/avatar_widget.dart';
import '../widgets/stat_card.dart';
import '../widgets/profile_action_card.dart';
import '../widgets/activity_card.dart';
import 'bookings_screen.dart';
import 'fav_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc()..add(LoadProfile()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ProfileLoaded) {
            final size = MediaQuery.of(context).size;
            final double horizontalPadding = size.width * 0.06;
            final double avatarSize = size.width * 0.22 > 110 ? 110 : size.width * 0.22;
            final double statCardWidth = (size.width - 2 * horizontalPadding - 32) / 3;
            final double actionCardWidth = (size.width - 2 * horizontalPadding - 18) / 2;
            final String initial = state.name.isNotEmpty ? state.name[0].toUpperCase() : 'A';
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
                    AvatarWidget(initial: initial, size: avatarSize),
                    const SizedBox(height: 18),
                    Text(state.name, style: AppTextStyles.title(fontSize: 28)),
                    const SizedBox(height: 6),
                    Text(state.subtitle, style: AppTextStyles.body(color: Colors.black54, fontSize: 16)),
                    const SizedBox(height: 24),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StatCard(
                            value: state.stylesTried.toString(),
                            label: 'Styles Tried',
                            color: const Color(0xFFa21caf),
                            width: statCardWidth,
                          ),
                          StatCard(
                            value: state.salonVisits.toString(),
                            label: 'Salon Visits',
                            color: const Color(0xFFec4899),
                            width: statCardWidth,
                          ),
                          StatCard(
                            value: state.savedStyles.toString(),
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
                          ProfileActionCard(
                            icon: FontAwesomeIcons.heart,
                            title: 'Favorites',
                            subtitle: '${state.savedStyles} saved styles',
                            gradient: const LinearGradient(colors: [Color(0xFFa78bfa), Color(0xFFf472b6)]),
                            width: actionCardWidth,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                            ),
                          ),
                          const SizedBox(width: 18),
                          ProfileActionCard(
                            icon: FontAwesomeIcons.calendar,
                            title: 'Bookings',
                            subtitle: 'Your appointments',
                            gradient: const LinearGradient(colors: [Color(0xFF60a5fa), Color(0xFF818cf8)]),
                            width: actionCardWidth,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => BookingsScreen()),
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
                        children: state.activities
                            .map((a) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ActivityCard(icon: a.icon, title: a.title, subtitle: a.subtitle),
                        ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          } else if (state is ProfileError) {
            return Scaffold(
              body: Center(child: Text(state.message)),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
