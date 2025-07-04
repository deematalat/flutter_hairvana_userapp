import 'package:flutter/material.dart';
import '../../../../../../core/styles/text_styles.dart';
import '../../../../../../core/widgets/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key,}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;

  late final AnimationController _textController;
  late final Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    _logoController.forward().then((_) {
      _textController.forward();
      Future.delayed(const Duration(milliseconds: 1200));
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final logoSize = width * 0.22;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFa78bfa),
              Color(0xFFf472b6),
              Color(0xFFdbeafe),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedLogo(
                size: logoSize,
                scale: _logoScale,
                opacity: _logoOpacity,
              ),
              const SizedBox(height: 24),
              FadeTransition(
                opacity: _textOpacity,
                child: Column(
                  children: [
                    Text(
                      'Hairvana',
                      style: AppTextStyles.largeTitle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your Personal Style Coach',
                      style: AppTextStyles.subtitle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
