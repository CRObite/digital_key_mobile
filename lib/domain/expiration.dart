import 'package:json_annotation/json_annotation.dart';

part 'expiration.g.dart';

@JsonSerializable()
class Expiration{

  @JsonKey(name: 'expires_at')
  String? expiresAt;

  @JsonKey(name: 'days_left')
  int? daysLeft;

  Expiration(this.expiresAt, this.daysLeft);


  factory Expiration.fromJson(Map<String, dynamic> json) => _$ExpirationFromJson(json);
  Map<String, dynamic> toJson() => _$ExpirationToJson(this);
}