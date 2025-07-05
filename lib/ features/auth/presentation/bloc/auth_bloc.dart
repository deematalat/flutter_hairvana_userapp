import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState(
    email: '',
    password: '',
    confirmPassword: '',
    isLogin: true,
    isLoading: false,
    error: null,
    showPassword: false,
    showConfirmPassword: false,
  )) {
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<AuthToggleMode>(_onToggleMode);
    on<AuthTogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<AuthToggleConfirmPasswordVisibility>(_onToggleConfirmPasswordVisibility);
    on<AuthSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(AuthEmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email, error: null));
  }

  void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password, error: null));
  }

  void _onConfirmPasswordChanged(AuthConfirmPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword, error: null));
  }

  void _onToggleMode(AuthToggleMode event, Emitter<AuthState> emit) {
    emit(state.copyWith(isLogin: !state.isLogin, error: null));
  }

  void _onTogglePasswordVisibility(AuthTogglePasswordVisibility event, Emitter<AuthState> emit) {
    emit(state.copyWith(showPassword: !state.showPassword));
  }

  void _onToggleConfirmPasswordVisibility(AuthToggleConfirmPasswordVisibility event, Emitter<AuthState> emit) {
    emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
  }

  void _onSubmitted(AuthSubmitted event, Emitter<AuthState> emit) async {
    // Validate inputs
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(error: 'Please fill in all fields'));
      return;
    }

    if (!state.isLogin && state.password != state.confirmPassword) {
      emit(state.copyWith(error: 'Passwords do not match'));
      return;
    }

    if (!state.isLogin && state.password.length < 6) {
      emit(state.copyWith(error: 'Password must be at least 6 characters'));
      return;
    }

    // Email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(state.email)) {
      emit(state.copyWith(error: 'Please enter a valid email'));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // For demo purposes, always succeed
      emit(state.copyWith(isLoading: false, success: true, error: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Authentication failed. Please try again.'));
    }
  }
} 