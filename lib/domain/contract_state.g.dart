// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractState _$ContractStateFromJson(Map<String, dynamic> json) =>
    ContractState(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      $enumDecodeNullable(_$ClientStatusEnumMap, json['type']),
      json['created_date'] as String?,
      json['display_name'] as String?,
    );

Map<String, dynamic> _$ContractStateToJson(ContractState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$ClientStatusEnumMap[instance.type],
      'created_date': instance.createdDate,
      'display_name': instance.displayName,
    };

const _$ClientStatusEnumMap = {
  ClientStatus.ACTIVE: 'ACTIVE',
  ClientStatus.TERMINATED: 'TERMINATED',
  ClientStatus.STOPPED: 'STOPPED',
  ClientStatus.DELETION: 'DELETION',
  ClientStatus.NEW: 'NEW',
  ClientStatus.DRAFT: 'DRAFT',
};
