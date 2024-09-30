// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tariff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tariff _$TariffFromJson(Map<String, dynamic> json) => Tariff(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      (json['max'] as num?)?.toInt(),
      (json['min'] as num?)?.toInt(),
      json['is_percent'] as bool?,
      (json['price'] as num?)?.toInt(),
      json['contract_type'] == null
          ? null
          : ContractType.fromJson(
              json['contract_type'] as Map<String, dynamic>),
      (json['contract_type_id'] as num?)?.toInt(),
      (json['contract_condition_id'] as num?)?.toInt(),
      json['display_name'] as String?,
    );

Map<String, dynamic> _$TariffToJson(Tariff instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'max': instance.max,
      'min': instance.min,
      'is_percent': instance.isPercent,
      'price': instance.price,
      'contract_type': instance.contractType,
      'contract_type_id': instance.contractTypeId,
      'contract_condition_id': instance.contractConditionId,
      'display_name': instance.displayName,
    };
