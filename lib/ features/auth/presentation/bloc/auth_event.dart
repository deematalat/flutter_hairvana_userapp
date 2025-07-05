import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthEmailChanged extends AuthEvent {
  final String email;
  AuthEmailChanged(this.email);
  @override
  List<Object?> get props => [email];
}

class AuthPasswordChanged extends AuthEvent {
  final String password;
  AuthPasswordChanged(this.password);
  @override
  List<Object?> get props => [password];
}

class AuthConfirmPasswordChanged extends AuthEvent {
  final String confirmPassword;
  AuthConfirmPasswordChanged(this.confirmPassword);
  @override
  List<Object?> get props => [confirmPassword];
}

class AuthToggleMode extends AuthEvent {}
class AuthTogglePasswordVisibility extends AuthEvent {}
class AuthToggleConfirmPasswordVisibility extends AuthEvent {}
class AuthSubmitted extends AuthEvent {} 