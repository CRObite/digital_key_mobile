// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['bin_iin'] as String?,
      json['status'] as String?,
      json['uuid'] as String?,
      json['type'] as String?,
      json['partner'] as bool?,
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bin_iin': instance.binIin,
      'status': instance.status,
      'uuid': instance.uuid,
      'type': instance.type,
      'partner': instance.partner,
    };
