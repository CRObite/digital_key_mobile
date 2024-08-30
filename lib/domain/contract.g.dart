// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contract _$ContractFromJson(Map<String, dynamic> json) => Contract(
      (json['id'] as num).toInt(),
      json['active'] as bool?,
      json['number'] as String?,
      json['closing_date'] as String?,
      json['created_date'] as String?,
      json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
      (json['client_id'] as num?)?.toInt(),
      json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'number': instance.number,
      'closing_date': instance.closingDate,
      'created_date': instance.createdDate,
      'client': instance.client,
      'client_id': instance.clientId,
      'currency': instance.currency,
      'company': instance.company,
    };
