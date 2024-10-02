// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metric_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetricReport _$MetricReportFromJson(Map<String, dynamic> json) => MetricReport(
      (json['id'] as num?)?.toInt(),
      metricsReportTypeFromJson(json['type'] as String?),
      json['resource'] == null
          ? null
          : MetricResource.fromJson(json['resource'] as Map<String, dynamic>),
      json['fetched_at'] as String?,
      json['metrics'] == null
          ? null
          : Metrics.fromJson(json['metrics'] as Map<String, dynamic>),
      json['display_name'] as String?,
    );

Map<String, dynamic> _$MetricReportToJson(MetricReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': metricsReportTypeToJson(instance.type),
      'resource': instance.resource,
      'fetched_at': instance.fetchedAt,
      'metrics': instance.metrics,
      'display_name': instance.displayName,
    };
