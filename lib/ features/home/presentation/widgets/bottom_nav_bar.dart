import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: 'AR',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_library),
          label: 'Gallery',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Salons',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Coach',
        ),
      ],
    );
  }
}