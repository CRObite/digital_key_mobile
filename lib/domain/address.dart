import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/config/address_type_enum.dart';

part 'address.g.dart';

@JsonSerializable()
class Address{

  int? id;

  @JsonKey(name: 'full_address')
  String? fullAddress;

  @JsonKey(fromJson: addressTypeFromJson,toJson: addressTypeToJson)
  AddressType? type;


  Address(this.id, this.fullAddress, this.type);

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

