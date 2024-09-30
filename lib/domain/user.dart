import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/position.dart';

import 'avatar.dart';

part 'user.g.dart';

@JsonSerializable()
class User{
  int id;
  String? name;
  String? iin;
  String? login;
  String? email;
  Avatar? avatar;

  @JsonKey(name: 'avatar_id')
  int? avatarId;
  String? mobile;

  @JsonKey(name: 'birth_day')
  String? birthDay;

  @JsonKey(name: 'app_role_id')
  int? appRoleId;

  Position? position;


  User(this.id, this.name, this.iin, this.login, this.email, this.avatar,
      this.avatarId, this.mobile, this.birthDay, this.appRoleId, this.position);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}