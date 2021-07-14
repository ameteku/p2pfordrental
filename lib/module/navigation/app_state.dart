import 'package:flutter/material.dart';
import 'package:p2pfordrental/models/user.dart';
import 'package:p2pfordrental/models/vehicle.dart';

class AppState extends ChangeNotifier {
  User? _loggedInUser = User(
    name: "Michael Ameteku",
    phoneNumber: "3307807220",
  );

  User? get currentUser => _loggedInUser;
  set currentUser(User? user) {
    _loggedInUser = user;
  }

  Vehicle? _selectedCar = Vehicle(name: "Fprd", owner: "Ameteku", currentMileage: 2000000, oldMileage: 100000);

  Vehicle? get car => _selectedCar;
  set car(Vehicle? vehicle) {
    car = vehicle;
  }
}
