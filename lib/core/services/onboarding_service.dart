import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  final SharedPreferences _prefs;

  OnboardingService(this._prefs);

  bool get isCompleted => _prefs.getBool('onboarding_completed') ?? false;

  Future<void> complete() async {
    await _prefs.setBool('onboarding_completed', true);
  }
}
