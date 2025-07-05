import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/onboarding_page_indicator.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_skip_button.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinish;
  const OnboardingScreen({Key? key, required this.onFinish}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  bool _nextHover = false;

  final List<_OnboardingPageData> _pages = [
    _OnboardingPageData(
      icon: FontAwesomeIcons.wandMagicSparkles,
      iconColor: Color(0xFFa78bfa),
      title: 'Welcome to Hairvana!',
      subtitle: 'See how new hairstyles look on you, instantly and confidently — with AR and AI magic.',
    ),
    _OnboardingPageData(
      icon: FontAwesomeIcons.camera,
      iconColor: Color(0xFFec4899),
      title: 'Try Before You Cut',
      subtitle: 'Use your camera to preview hundreds of hairstyles in real-time AR.',
    ),
    _OnboardingPageData(
      icon: FontAwesomeIcons.bolt,
      iconColor: Color(0xFF60a5fa),
      title: 'AI-Powered Suggestions',
      subtitle: 'Our AI evaluates your chosen style, face shape, and tone to guide you to your best look.',
    ),
    _OnboardingPageData(
      icon: FontAwesomeIcons.circleCheck,
      iconColor: Color(0xFF22c55e),
      title: 'Save & Share Styles',
      subtitle: 'Save your looks, rate them, and ask friends to vote on what suits you best — all in one tap!',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      widget.onFinish();
    }
  }

  void _skip() {
    widget.onFinish();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, i) {
                  final page = _pages[i];
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: const Offset(0.2, 0),
                        end: Offset.zero,
                      ).animate(animation);
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: OnboardingPage(
                      key: ValueKey(i),
                      icon: page.icon,
                      iconColor: page.iconColor,
                      title: page.title,
                      subtitle: page.subtitle,
                      size: size,
                    ),
                  );
                },
              ),
            ),
            OnboardingPageIndicator(
              pageCount: _pages.length,
              currentPage: _currentPage,
              onDotTap: (i) {
                _controller.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 8),
              child: OnboardingNextButton(
                isLastPage: _currentPage == _pages.length - 1,
                isHover: _nextHover,
                onTap: _nextPage,
                onHoverEnter: () => setState(() => _nextHover = true),
                onHoverExit: () => setState(() => _nextHover = false),
                fontSize: size.width * 0.055 > 26 ? 26 : size.width * 0.055,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.04, top: 8),
              child: OnboardingSkipButton(
                onTap: _skip,
                fontSize: size.width * 0.045 > 20 ? 20 : size.width * 0.045,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageData {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  const _OnboardingPageData({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });
}
