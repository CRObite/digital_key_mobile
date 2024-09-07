// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      json['full_address'] as String?,
      addressTypeFromJson(json['type'] as String?),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'full_address': instance.fullAddress,
      'type': addressTypeToJson(instance.type),
    };
