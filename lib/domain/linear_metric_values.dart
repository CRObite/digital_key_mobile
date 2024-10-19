

import 'package:json_annotation/json_annotation.dart';

part 'linear_metric_values.g.dart';

@JsonSerializable()
class LinearMetricValues{
  String? metric;
  Map<String,double>? values;

  LinearMetricValues(this.metric, this.values);

  factory LinearMetricValues.fromJson(Map<String, dynamic> json) => _$LinearMetricValuesFromJson(json);
  Map<String, dynamic> toJson() => _$LinearMetricValuesToJson(this);
}