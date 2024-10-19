// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metric_report_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetricReportGroup _$MetricReportGroupFromJson(Map<String, dynamic> json) =>
    MetricReportGroup(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['logo'] == null
          ? null
          : Attachment.fromJson(json['logo'] as Map<String, dynamic>),
      (json['content'] as List<dynamic>?)
          ?.map((e) => MetricReport.fromJson(e as Map<String, dynamic>))
          .toList(),
      MetricReportGroup._metricsFromJson(
          json['metrics'] as Map<String, dynamic>),
      (json['services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MetricReportGroupToJson(MetricReportGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'content': instance.content,
      'metrics': MetricReportGroup._metricsToJson(instance.metrics),
      'services': instance.services,
    };
