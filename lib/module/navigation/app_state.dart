import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:p2pfordrental/models/user.dart';
import 'package:p2pfordrental/models/vehicle.dart';
import 'package:p2pfordrental/repo/api_repo.dart';

enum UserStatus { Renter, Rentee }

class AppState extends ChangeNotifier {
  AppState() : appApis = ApiRepo();

  User? _loggedInUser = User(
    name: "Michael Ameteku",
    phoneNumber: "3307807220",
  );

  UserStatus? _status;

  Vehicle? _selectedCar = Vehicle(name: "Ford Escape", ownerId: "Ameteku", currentMileage: 2000000, oldMileage: 100000);

  ApiRepo appApis;

  User? get currentUser => _loggedInUser;
  set currentUser(User? user) {
    _loggedInUser = user;
    // notifyListeners();
  }

  Vehicle? get car => _selectedCar;
  set car(Vehicle? vehicle) {
    print(" in function");
    _selectedCar = vehicle;

    print("Done setting in function");
    notifyListeners();
  }

  UserStatus? get status => _status;

  set status(UserStatus? status) {
    _status = status;
    //notifyListeners();
  }
}
