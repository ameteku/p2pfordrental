import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(ignore: true)
  String id;
  String userName;
  String name;
  int passCode;
  bool isAdmin = false;
  bool isApproved = false;
  Map<String, String> usersAdded;
  bool displayNumbers;
  String phoneNumber;
  User(
      {this.displayNumbers,
      this.phoneNumber,
      this.userName,
      this.name,
      this.isAdmin = false,
      this.passCode,
      this.isApproved = false,
      this.usersAdded});

  factory User.fromJson(Map json, String id) {
    User mc = _$UserFromJson(json);
    mc.id = id;
    mc.displayNumbers = json['showNumbers'];
    return mc;
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String toString() {
    return 'User{id: $id, userName: $userName, name: $name, passcode: $passCode, isAdmin: $isAdmin, isApproved: $isApproved}';
  }
}
