import 'package:flutter/material.dart';

class PaymentDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;
  const PaymentDetailsAppBar({required this.onBack, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onBack,
      ),
      title: const Text('Payment Details', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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