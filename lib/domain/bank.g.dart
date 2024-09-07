// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) => Bank(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['bik'] as String?,
      json['bank_code'] as String?,
      json['logo'] == null
          ? null
          : Attachment.fromJson(json['logo'] as Map<String, dynamic>),
      (json['logo_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bik': instance.bik,
      'bank_code': instance.bankCode,
      'logo': instance.logo,
      'logo_id': instance.logoId,
    };
