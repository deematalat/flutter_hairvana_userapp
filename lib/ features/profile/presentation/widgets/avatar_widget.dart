import 'package:flutter/material.dart';
import '../../../../core/styles/text_styles.dart';

class AvatarWidget extends StatelessWidget {
  final String initial;
  final double size;
  const AvatarWidget({Key? key, required this.initial, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
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
          style: AppTextStyles.largeTitle(color: Colors.white, fontSize: size * 0.45),
        ),
      ),
    );
  }
} 