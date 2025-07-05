import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final bool isLogin;
  final bool isLoading;
  final String? error;
  final bool showPassword;
  final bool showConfirmPassword;
  final bool success;

  const AuthState({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isLogin,
    required this.isLoading,
    this.error,
    required this.showPassword,
    required this.showConfirmPassword,
    this.success = false,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        isLogin,
        isLoading,
        error,
        showPassword,
        showConfirmPassword,
        success,
      ];

  AuthState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isLogin,
    bool? isLoading,
    String? error,
    bool? showPassword,
    bool? showConfirmPassword,
    bool? success,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLogin: isLogin ?? this.isLogin,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      success: success ?? this.success,
    );
  }
} 