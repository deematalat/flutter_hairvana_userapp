import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading()) {
    on<LoadProfile>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ProfileLoaded(
        name: 'Alex Johnson',
        subtitle: 'Hair enthusiast since 2023',
        stylesTried: 12,
        salonVisits: 5,
        savedStyles: 8,
        activities: const [
          Activity(icon: FontAwesomeIcons.camera, title: 'Tried AR with Curtain Bangs', subtitle: '2 hours ago'),
          Activity(icon: FontAwesomeIcons.heart, title: 'Saved Beach Waves style', subtitle: '1 day ago'),
          Activity(icon: FontAwesomeIcons.calendar, title: 'Booked appointment with Sarah', subtitle: '3 days ago'),
        ],
      ));
    });
  }
} 