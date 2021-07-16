import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:p2pfordrental/models/user.dart' as CustomUser;
import 'package:p2pfordrental/models/vehicle.dart';
import 'package:p2pfordrental/repo/firestore_base.dart';

//this is the interface between firestore and app
class UserRepo extends FireStoreBaseRepo {
  String userpath = "users";
  String carPath = "vehicles";
  Future<CustomUser.User?> getUser(String role) async {
    CustomUser.User? temp;
    print("getting user");
    await FireStoreBaseRepo.db().collection(userpath).where('role', isEqualTo: role).limit(1).get().then((value) {
      var doc = value.docs.first;
      print("doc is ${doc.data()}");
      temp = CustomUser.User.fromJson(doc.data(), doc.id);
    });

    return temp;
  }

  //gets the vehicles
  Future<List<Vehicle>?> getUserVehicles(String id) async {
    List<Vehicle>? cars;
    await FireStoreBaseRepo.db().collection(carPath).where('ownerId', isEqualTo: id).get().then((value) {
      cars = value.docs.map((e) => Vehicle.fromJson(e.data(), e.id)).toList();
    });
    cars?.addAll(
      [
        Vehicle(
          name: "Ford Truck",
          oldMileage: 70000,
          currentMileage: 75000,
          rented: false,
          imageUrl:
              "https://images.unsplash.com/photo-1551830820-330a71b99659?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80",
        ),
        Vehicle(
          name: "Ford fusion",
          ownerId: "Ameteku",
          currentMileage: 150000,
          oldMileage: 100000,
          imageUrl:
              "https://images.unsplash.com/photo-1582467029213-ce71667c2e28?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
        )
      ],
    );
    return cars;
    // return cars;
  }

  void addVehicle(Vehicle vehicle) {
    FireStoreBaseRepo.db().collection(carPath).add(vehicle.toJson());
    print("Added vehicle to db");
  }

  void updateVehicle(Vehicle vehicle) {
    FireStoreBaseRepo.db().collection(carPath).doc(vehicle.id).update(vehicle.toJson());
  }
}
