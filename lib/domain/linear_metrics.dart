
import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/linear_metric_values.dart';


part 'linear_metrics.g.dart';

@JsonSerializable()
class LinearMetrics{
  List<LinearMetricValues> values;

  LinearMetrics(this.values);

  factory LinearMetrics.fromJson(Map<String, dynamic> json) => _$LinearMetricsFromJson(json);
  Map<String, dynamic> toJson() => _$LinearMetricsToJson(this);
}

