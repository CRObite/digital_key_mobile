// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linear_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinearMetrics _$LinearMetricsFromJson(Map<String, dynamic> json) =>
    LinearMetrics(
      (json['values'] as List<dynamic>)
          .map((e) => LinearMetricValues.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LinearMetricsToJson(LinearMetrics instance) =>
    <String, dynamic>{
      'values': instance.values,
    };
