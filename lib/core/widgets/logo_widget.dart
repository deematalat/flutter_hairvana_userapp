import 'package:flutter/material.dart';

class AnimatedLogo extends StatelessWidget {
  final double size;
  final Animation<double> scale;
  final Animation<double> opacity;

  const AnimatedLogo({
    Key? key,
    required this.size,
    required this.scale,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: FadeTransition(
        opacity: opacity,
        child: Image.asset(
          'assets/logo.png',
          width: size.clamp(160, 320),
          height: size.clamp(160, 320),
        ),
      ),
    );
  }
}
