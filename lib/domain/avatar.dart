
import 'package:json_annotation/json_annotation.dart';

part 'avatar.g.dart';

@JsonSerializable()
class Avatar{
  int id;
  String url;

  Avatar(this.id, this.url);

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}