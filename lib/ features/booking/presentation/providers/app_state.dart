import 'package:flutter/material.dart';
import '../../../home/presentation/domain/entities/style_item.dart';
import '../../domain/entities/booking.dart';




class AppState extends ChangeNotifier {
  final List<StyleItem> _favorites = [];
  final List<Booking> _bookings = [];

  List<StyleItem> get favorites => List.unmodifiable(_favorites);
  List<Booking> get bookings => List.unmodifiable(_bookings);

  void addFavorite(StyleItem item) {
    if (!_favorites.contains(item)) {
      _favorites.add(item);
      notifyListeners();
    }
  }

  void removeFavorite(StyleItem item) {
    _favorites.remove(item);
    notifyListeners();
  }

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void removeBooking(Booking booking) {
    _bookings.remove(booking);
    notifyListeners();
  }
}
