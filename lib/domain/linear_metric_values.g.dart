// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linear_metric_values.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinearMetricValues _$LinearMetricValuesFromJson(Map<String, dynamic> json) =>
    LinearMetricValues(
      json['metric'] as String?,
      (json['values'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$LinearMetricValuesToJson(LinearMetricValues instance) =>
    <String, dynamic>{
      'metric': instance.metric,
      'values': instance.values,
    };
