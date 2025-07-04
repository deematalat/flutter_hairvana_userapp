import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

import '../services/onboarding_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton<OnboardingService>(() => OnboardingService(prefs));
  sl.registerLazySingleton<AuthService>(() => AuthService());

}
