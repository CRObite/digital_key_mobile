// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      (json['id'] as num?)?.toInt(),
      json['code'] as String?,
      json['name'] as String?,
      json['logo'] == null
          ? null
          : Attachment.fromJson(json['logo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'logo': instance.logo,
    };
