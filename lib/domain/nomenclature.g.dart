// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nomenclature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nomenclature _$NomenclatureFromJson(Map<String, dynamic> json) => Nomenclature(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['code'] as String?,
      json['is_budget'] as bool?,
      json['is_fee'] as bool?,
      json['auto_computable'] as bool?,
      json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      (json['service_id'] as num?)?.toInt(),
      json['display_name'] as String?,
    );

Map<String, dynamic> _$NomenclatureToJson(Nomenclature instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'is_budget': instance.isBudget,
      'is_fee': instance.isFee,
      'auto_computable': instance.autoComputable,
      'service': instance.service,
      'service_id': instance.serviceId,
      'display_name': instance.displayName,
    };
