import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p2pfordrental/models/vehicle.dart';
import 'package:pretty_json/pretty_json.dart';
//refresh token, then make calls to for vehicle information

//create stream for location retrieval

//use firestore to add data extra items

//take

class ApiRepo {
  final http.Client client;
  String basePath = 'http://localhost:3000';
  String refreshPath = '/refresh';
  String vehicleInfo = '/vehicle_info';
  String location = '/location';

  dynamic headers = {
    "Access-Control-Allow-Origin": "*",
  };
  //first we have to get fresh token so in constructor call basepath

  ApiRepo() : client = http.Client() {
    print("Getting token");
    try {
      client.get(urlConcat([basePath]), headers: headers).then((res) {
        print("body is" + res.body.toString());

        print("Status code is" + res.statusCode.toString());
      }).catchError((err) {
        print("error in catch: $err");
      });
    } catch (e, trace) {
      print("Error occured: " + e.toString());
    }

    getVehicleInformation();
  }

  void getVehicleInformation() {
    client.get(urlConcat([basePath, vehicleInfo]), headers: {
      'Content-Type': 'application/json',
    }).then((value) {
      // print(value.body);
      Map<dynamic, dynamic> vehicleItems = jsonDecode(value.body) as Map<dynamic, dynamic>;
      //dynamic sec = jsonDecode(vehicleItems);
      print("Items are ${vehicleItems.runtimeType}vehicleItems");

      //parse the info and get new data from the vehicle
      //Vehicle()
    });
  }

  Uri urlConcat(List<String> pieces) {
    return Uri.parse(pieces.join());
  }
}
