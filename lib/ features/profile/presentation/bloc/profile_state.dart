import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Activity {
  final IconData icon;
  final String title;
  final String subtitle;
  const Activity({required this.icon, required this.title, required this.subtitle});
}

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String subtitle;
  final int stylesTried;
  final int salonVisits;
  final int savedStyles;
  final List<Activity> activities;
  const ProfileLoaded({required this.name, required this.subtitle, required this.stylesTried, required this.salonVisits, required this.savedStyles, required this.activities});
  @override
  List<Object?> get props => [name, subtitle, stylesTried, salonVisits, savedStyles, activities];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
  @override
  List<Object?> get props => [message];
} 