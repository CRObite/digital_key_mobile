// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['bin_iin'] as String?,
      statusFromJson(json['status'] as String),
      closingFormFromJson(json['closing_form'] as String?),
      json['uuid'] as String?,
      json['type'] as String?,
      json['partner'] as bool?,
      json['expiration'] == null
          ? null
          : Expiration.fromJson(json['expiration'] as Map<String, dynamic>),
      (json['contacts'] as List<dynamic>?)
          ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bin_iin': instance.binIin,
      'status': statusToJson(instance.status),
      'closing_form': closingFormToJson(instance.closingForm),
      'uuid': instance.uuid,
      'type': instance.type,
      'partner': instance.partner,
      'expiration': instance.expiration,
      'contacts': instance.contacts,
    };
