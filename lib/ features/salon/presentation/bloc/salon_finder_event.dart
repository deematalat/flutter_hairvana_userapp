import 'package:equatable/equatable.dart';

abstract class SalonFinderEvent extends Equatable {
  const SalonFinderEvent();
  @override
  List<Object?> get props => [];
}

class LoadSalons extends SalonFinderEvent {} 