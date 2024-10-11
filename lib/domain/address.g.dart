// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      (json['id'] as num?)?.toInt(),
      json['full_address'] as String?,
      addressTypeFromJson(json['type'] as String?),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'full_address': instance.fullAddress,
      'type': addressTypeToJson(instance.type),
    };
