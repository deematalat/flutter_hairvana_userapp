import 'package:equatable/equatable.dart';
import '../../domain/salon.dart';

abstract class SalonFinderState extends Equatable {
  const SalonFinderState();
  @override
  List<Object?> get props => [];
}

class SalonFinderLoading extends SalonFinderState {}

class SalonFinderLoaded extends SalonFinderState {
  final List<Salon> salons;
  const SalonFinderLoaded(this.salons);
  @override
  List<Object?> get props => [salons];
}

class SalonFinderError extends SalonFinderState {
  final String message;
  const SalonFinderError(this.message);
  @override
  List<Object?> get props => [message];
}

class SalonFinderEmpty extends SalonFinderState {} 