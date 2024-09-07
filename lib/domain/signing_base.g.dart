// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signing_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigningBase _$SigningBaseFromJson(Map<String, dynamic> json) => SigningBase(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['display_name'] as String?,
    );

Map<String, dynamic> _$SigningBaseToJson(SigningBase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'display_name': instance.displayName,
    };
