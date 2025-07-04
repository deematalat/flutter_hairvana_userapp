import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/styles/text_styles.dart';


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
                    child: _OnboardingPage(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (i) => GestureDetector(
                onTap: () {
                  _controller.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                  width: i == _currentPage ? 24 : 10,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: i == _currentPage ? const Color(0xFFa78bfa) : const Color(0xFFede9fe),
                  ),
                ),
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 8),
              child: MouseRegion(
                onEnter: (_) => setState(() => _nextHover = true),
                onExit: (_) => setState(() => _nextHover = false),
                child: GestureDetector(
                  onTap: _nextPage,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.025),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        colors: _nextHover
                            ? [Color(0xFFa78bfa), Color(0xFFf472b6)]
                            : [Color(0xFFa78bfa), Color(0xFFf472b6), Color(0xFFfb7185)],
                      ),
                      boxShadow: [
                        if (_nextHover)
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.18),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentPage == _pages.length - 1 ? 'Finish' : 'Next →',
                          style: AppTextStyles.button(
                            fontSize: size.width * 0.055 > 26 ? 26 : size.width * 0.055,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.04, top: 8),
              child: GestureDetector(
                onTap: _skip,
                child: Text(
                  'Skip',
                  style: AppTextStyles.button(
                    color: const Color(0xFFa78bfa),
                    fontSize: size.width * 0.045 > 20 ? 20 : size.width * 0.045,
                    fontWeight: FontWeight.w900,
                  ),
                ),
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

class _OnboardingPage extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Size size;
  const _OnboardingPage({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconSize = size.width * 0.18;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(icon, size: iconSize.clamp(50, 100), color: iconColor),
        SizedBox(height: size.height * 0.04),
        Text(
          title,
          style: AppTextStyles.title(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: size.height * 0.025),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Text(
            subtitle,
            style: AppTextStyles.subtitle(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
