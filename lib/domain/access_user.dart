import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/user.dart';

part 'access_user.g.dart';

@JsonSerializable()
class AccessUser {
  @JsonKey(name: 'access_token')
  String accessToken;

  @JsonKey(name: 'refresh_token')
  String refreshToken;
  User? user;

  AccessUser(this.accessToken, this.refreshToken, this.user);

  factory AccessUser.fromJson(Map<String, dynamic> json) => _$AccessUserFromJson(json);
  Map<String, dynamic> toJson() => _$AccessUserToJson(this);
}



