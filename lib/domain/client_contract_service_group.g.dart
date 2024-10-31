// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_contract_service_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientContractServiceGroup _$ClientContractServiceGroupFromJson(
        Map<String, dynamic> json) =>
    ClientContractServiceGroup(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['logo'] == null
          ? null
          : Attachment.fromJson(json['logo'] as Map<String, dynamic>),
      (json['content'] as List<dynamic>?)
          ?.map(
              (e) => ClientContractService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClientContractServiceGroupToJson(
        ClientContractServiceGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'content': instance.content,
    };
