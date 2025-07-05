import 'package:flutter/material.dart';

class OnboardingNextButton extends StatelessWidget {
  final bool isLastPage;
  final bool isHover;
  final VoidCallback onTap;
  final VoidCallback onHoverEnter;
  final VoidCallback onHoverExit;
  final double fontSize;

  const OnboardingNextButton({
    Key? key,
    required this.isLastPage,
    required this.isHover,
    required this.onTap,
    required this.onHoverEnter,
    required this.onHoverExit,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHoverEnter(),
      onExit: (_) => onHoverExit(),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFa78bfa), Color(0xFFf472b6), Color(0xFFfb7185)],
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: isHover ? [
              BoxShadow(
                color: Colors.purple.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ] : [
              BoxShadow(
                color: Colors.purple.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              isLastPage ? 'Get Started' : 'Next',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 