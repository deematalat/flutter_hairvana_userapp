import 'package:flutter_bloc/flutter_bloc.dart';
import 'salon_finder_event.dart';
import 'salon_finder_state.dart';
import '../../data/repositories/salonRepository_impl.dart';

class SalonFinderBloc extends Bloc<SalonFinderEvent, SalonFinderState> {
  SalonFinderBloc() : super(SalonFinderLoading()) {
    on<LoadSalons>((event, emit) async {
      emit(SalonFinderLoading());
      try {
        final salons = await FakeSalonRepository().getSalons();
        if (salons.isEmpty) {
          emit(SalonFinderEmpty());
        } else {
          emit(SalonFinderLoaded(salons));
        }
      } catch (e) {
        emit(SalonFinderError(e.toString()));
      }
    });
  }
} 