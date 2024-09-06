import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/config/address_type_enum.dart';

class Address{

  @JsonKey(name: 'full_address')
  String fullAddress;

  AddressType type;

  Address(this.fullAddress, this.type);
}

