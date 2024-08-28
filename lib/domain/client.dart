import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client{
  int? id;
  String? name;

  @JsonKey(name: 'bin_iin')
  String? binIin;

  String? status;
  String? uuid;
  String? type;
  bool? partner;

  Client(this.id, this.name, this.binIin, this.status, this.uuid, this.type,
      this.partner);

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}