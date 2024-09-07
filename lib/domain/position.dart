import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

@JsonSerializable()
class Position{
  int id;
  String? name;

  @JsonKey(name: 'display_name')
  String? displayName;

  Position(this.id, this.name, this.displayName);

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);
  Map<String, dynamic> toJson() => _$PositionToJson(this);
}