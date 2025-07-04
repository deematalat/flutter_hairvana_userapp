import 'package:flutter/material.dart';

import '../../../../core/styles/text_styles.dart';


class AppGradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onProfileTap;
  final bool showProfileIcon;

  const AppGradientAppBar({
    Key? key,
    required this.title,
    required this.subtitle,
    this.onProfileTap,
    this.showProfileIcon = true,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(110);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 3),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.title(color: Colors.white, fontSize: 26)),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.body(color: Colors.white70, fontSize: 15)),
              ],
            ),
          ),
          if (showProfileIcon)
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.person, color: Colors.white, size: 28),
                onPressed: onProfileTap,
              ),
            ),
        ],
      ),
    );
  }
}
