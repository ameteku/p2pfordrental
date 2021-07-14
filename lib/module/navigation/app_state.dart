import 'package:flutter/material.dart';
import 'package:p2pfordrental/models/user.dart';
import 'package:p2pfordrental/models/vehicle.dart';

class AppState extends ChangeNotifier {
  User? _loggedInUser;

  User? get currentUser => _loggedInUser;
  set currentUser(User? user) {
    _loggedInUser = user;
  }

  Vehicle? _selectedCar;

  Vehicle? get car => _selectedCar;
  set car(Vehicle? vehicle) {
    car = vehicle;
  }
}
