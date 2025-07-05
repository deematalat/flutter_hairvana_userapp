import 'package:flutter/material.dart';

class PaymentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;
  const PaymentAppBar({required this.onBack, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Payment', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onBack,
      ),
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