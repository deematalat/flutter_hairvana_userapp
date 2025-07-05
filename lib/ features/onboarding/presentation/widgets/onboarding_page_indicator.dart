import 'package:flutter/material.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;
  final ValueChanged<int> onDotTap;
  const OnboardingPageIndicator({required this.pageCount, required this.currentPage, required this.onDotTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (i) => GestureDetector(
        onTap: () => onDotTap(i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
          width: i == currentPage ? 24 : 10,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: i == currentPage ? const Color(0xFFa78bfa) : const Color(0xFFede9fe),
          ),
        ),
      )),
    );
  }
} 