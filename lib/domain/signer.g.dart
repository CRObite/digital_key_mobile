// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Signer _$SignerFromJson(Map<String, dynamic> json) => Signer(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      $enumDecodeNullable(_$SignerTypeEnumMap, json['type']),
      json['position'] == null
          ? null
          : Position.fromJson(json['position'] as Map<String, dynamic>),
      (json['position_id'] as num?)?.toInt(),
      json['stamp_file'] == null
          ? null
          : Attachment.fromJson(json['stamp_file'] as Map<String, dynamic>),
      (json['stamp_file_id'] as num?)?.toInt(),
      json['signing_base'] == null
          ? null
          : SigningBase.fromJson(json['signing_base'] as Map<String, dynamic>),
      (json['signing_base_id'] as num?)?.toInt(),
      json['display_name'] as String?,
    );

Map<String, dynamic> _$SignerToJson(Signer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$SignerTypeEnumMap[instance.type],
      'position': instance.position,
      'position_id': instance.positionId,
      'stamp_file': instance.stampFile,
      'stamp_file_id': instance.stampFileId,
      'signing_base': instance.signingBase,
      'signing_base_id': instance.signingBaseId,
      'display_name': instance.displayName,
    };

const _$SignerTypeEnumMap = {
  SignerType.CHARTER: 'CHARTER',
  SignerType.ORDER: 'ORDER',
  SignerType.COUPON: 'COUPON',
  SignerType.ATTORNEY: 'ATTORNEY',
};
