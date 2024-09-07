import 'package:json_annotation/json_annotation.dart';


part 'signing_base.g.dart';

@JsonSerializable()
class SigningBase{
  int id;
  String? name;

  @JsonKey(name: 'display_name')
  String? displayName;

  SigningBase(this.id, this.name, this.displayName);

  factory SigningBase.fromJson(Map<String, dynamic> json) => _$SigningBaseFromJson(json);
  Map<String, dynamic> toJson() => _$SigningBaseToJson(this);
}
