// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractType _$ContractTypeFromJson(Map<String, dynamic> json) => ContractType(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['document_number_prefix'] as String?,
      (json['service_max'] as num?)?.toInt(),
      json['description'] as String?,
      json['billing'] as bool?,
    );

Map<String, dynamic> _$ContractTypeToJson(ContractType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'document_number_prefix': instance.documentNumberPrefix,
      'service_max': instance.serviceMax,
      'description': instance.description,
      'billing': instance.billing,
    };
