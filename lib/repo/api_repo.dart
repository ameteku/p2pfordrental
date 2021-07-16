import 'dart:io';
import 'dart:convert';
//refresh token, then make calls to for vehicle information

//create stream for location retrieval

//use firestore to add data extra items

//take

class ApiRepo {
  final HttpClient linker;
  String basePath = 'localhost:3000';
  String refreshPath = '/refresh';
  String vehicleInfo = '/vehicle_info';
  String location = '/location';

  //first we have to get fresh token so in constructor call basepath

  ApiRepo() : linker = HttpClient() {
    print("Getting token");
    linker.getUrl(Uri.parse(urlConcat([basePath]))).then((req) => req.close()).then((res) {
      print("Status code is" + res.statusCode.toString());
    });
  }

  String urlConcat(List<String> pieces) {
    return pieces.join();
  }
}
