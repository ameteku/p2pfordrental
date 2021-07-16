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
    List<Vehicle> cars;
    await FireStoreBaseRepo.db().collection(carPath).where('ownerId', isEqualTo: id).get().then((value) {
      return value.docs.map((e) => Vehicle.fromJson(e.data(), e.id)).toList();
    });

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
