// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metric_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetricResource _$MetricResourceFromJson(Map<String, dynamic> json) =>
    MetricResource(
      (json['id'] as num).toInt(),
      json['resource_id'] as String?,
      json['name'] as String?,
      json['resource_name'] as String?,
      json['status'] as String?,
      $enumDecodeNullable(_$MetricsReportTypeEnumMap, json['type']),
      json['start_date'] as String?,
      json['cabinet_id'] as String?,
      json['logo'] == null
          ? null
          : Attachment.fromJson(json['logo'] as Map<String, dynamic>),
      json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
      (json['client_id'] as num?)?.toInt(),
      json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      (json['service_id'] as num?)?.toInt(),
      json['client_contract_service'] == null
          ? null
          : ClientContractService.fromJson(
              json['client_contract_service'] as Map<String, dynamic>),
      (json['client_contract_service_id'] as num?)?.toInt(),
      json['display_name'] as String?,
    );

Map<String, dynamic> _$MetricResourceToJson(MetricResource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource_id': instance.resourceId,
      'name': instance.name,
      'resource_name': instance.resourceName,
      'status': instance.status,
      'type': _$MetricsReportTypeEnumMap[instance.type],
      'start_date': instance.startDate,
      'cabinet_id': instance.cabinetId,
      'logo': instance.logo,
      'client': instance.client,
      'client_id': instance.clientId,
      'service': instance.service,
      'service_id': instance.serviceId,
      'client_contract_service': instance.clientContractService,
      'client_contract_service_id': instance.clientContractServiceId,
      'display_name': instance.displayName,
    };

const _$MetricsReportTypeEnumMap = {
  MetricsReportType.SERVICE: 'SERVICE',
  MetricsReportType.CABINET: 'CABINET',
  MetricsReportType.CAMPAIGN: 'CAMPAIGN',
};
