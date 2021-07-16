// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) {
  return Vehicle(
    name: json['name'] as String,
    ownerId: json['ownerId'] as String,
    vehicleId: json['vehicleId'] as String,
    currentMileage: json['currentMileage'] as int,
    oldMileage: json['oldMileage'] as int,
    currentLocation: json['currentLocation'] == null
        ? null
        : MapCoordinates.fromJson(
            json['currentLocation'] as Map<String, dynamic>),
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'name': instance.name,
      'vehicleId': instance.vehicleId,
      'ownerId': instance.ownerId,
      'oldMileage': instance.oldMileage,
      'currentMileage': instance.currentMileage,
      'currentLocation': instance.currentLocation,
      'imageUrl': instance.imageUrl,
    };
