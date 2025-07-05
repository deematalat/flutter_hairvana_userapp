import 'package:flutter/material.dart';

class GalleryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GalleryAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text('Style Gallery', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
} 