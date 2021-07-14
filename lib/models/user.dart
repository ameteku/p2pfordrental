import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(ignore: true)
  String? id;
  String? userName;
  String? name;
  String? email;
  String? phoneNumber;
  List<String>? carIds;
  User({this.userName, this.name, this.id, this.carIds, this.email, this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json, String id) {
    User mc = _$UserFromJson(json);
    mc.id = id;
    return mc;
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String toString() {
    return 'User{id: $id, userName: $userName, name: $name, cardIds : $carIds, email: $email}';
  }
}
