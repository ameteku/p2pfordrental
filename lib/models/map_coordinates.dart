import 'package:json_annotation/json_annotation.dart';

part 'map_coordinates.g.dart';

@JsonSerializable()
class MapCoordinates {
  String longitude;
  String latitude;

  MapCoordinates(this.latitude, this.longitude);

  factory MapCoordinates.fromJson(Map<String, dynamic> json) {
    return _$MapCoordinatesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MapCoordinatesToJson(this);
  }

  @override
  String toString() {
    return "Coordinates{ lat: $latitude, long: $longitude}";
  }
}
