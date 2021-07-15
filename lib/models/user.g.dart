// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    userName: json['userName'] as String,
    name: json['name'] as String,
    carIds: (json['carIds'] as List).map((e) => e as String).toList(),
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userName': instance.userName,
      'name': instance.name,
      'email': instance.email,
      'carIds': instance.carIds,
    };
