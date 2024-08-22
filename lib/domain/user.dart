import 'package:json_annotation/json_annotation.dart';

import 'avatar.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  int id;
  String? name;
  String? iin;
  String? login;
  Avatar? avatar;

  User(this.id, this.name, this.iin, this.login, this.avatar);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}