import 'package:flutter/material.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/services/onboarding_service.dart';
import '../../../../main.dart';
import '../../../auth/presentation/screens/auth_screen.dart';
import '../../../onboarding/presentation/pages/onboarding_screen.dart';
import '../pages/splash_screen.dart';


class AppFlowController extends StatefulWidget {
  const AppFlowController({super.key});

  @override
  State<AppFlowController> createState() => _AppFlowControllerState();
}

class _AppFlowControllerState extends State<AppFlowController> {
  bool _isLoading = true;
  bool _showOnboarding = false;
  bool _showAuth = false;

  late final OnboardingService _onboardingService;

  @override
  void initState() {
    super.initState();
    _initFlow();
  }

  Future<void> _initFlow() async {
    try {
      print("🔧 Getting OnboardingService...");
      _onboardingService = sl<OnboardingService>();

      await Future.delayed(const Duration(seconds: 2));
      final completed = _onboardingService.isCompleted;
      print("✅ Onboarding completed: $completed");

      setState(() {
        _isLoading = false;
        _showOnboarding = !completed;
        _showAuth = completed;
      });
    } catch (e) {
      print("❌ Error in _initFlow: $e");
    }
  }

  void _finishOnboarding() async {
    await _onboardingService.complete();
    setState(() {
      _showOnboarding = false;
      _showAuth = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      print("🌀 Showing SplashScreen");
      return const SplashScreen(); // use simple version
    } else if (_showOnboarding) {
      print("🚀 Showing OnboardingScreen");
      return OnboardingScreen(onFinish: _finishOnboarding);
    } else if (_showAuth) {
      print("🔐 Showing AuthScreen");
      return const AuthScreen();
    } else {
      print("🏠 Showing MainNavigation");
      return const MainNavigation();
    }
  }
}




