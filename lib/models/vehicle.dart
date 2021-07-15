import 'package:json_annotation/json_annotation.dart';
import 'package:p2pfordrental/models/map_coordinates.dart';

part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle {
  @JsonKey(ignore: true)
  String? id;
  String? name;
  String? vehicleId;
  String? owner;
  int? oldMileage;
  int? currentMileage;
  MapCoordinates? currentLocation;
  String? imageUrl;

  Vehicle({this.id, this.name, this.owner, this.vehicleId, this.currentMileage, this.oldMileage, this.currentLocation, this.imageUrl});

  factory Vehicle.fromJson(Map<String, dynamic> json, String id) {
    Vehicle temp = _$VehicleFromJson(json);
    temp.id = id;
    return temp;
  }

  Map<String, dynamic> toJson() => _$VehicleToJson(this);

  @override
  String toString() => "Vehicle{name: $name, id: $id}";
}
