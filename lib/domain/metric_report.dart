import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/linear_metrics.dart';
import 'package:web_com/domain/metric_resource.dart';
import 'package:web_com/domain/metrics.dart';

import '../config/metrics_report_type_enum.dart';

part 'metric_report.g.dart';

@JsonSerializable()
class MetricReport{
  int? id;

  @JsonKey(fromJson: metricsReportTypeFromJson,toJson: metricsReportTypeToJson)
  MetricsReportType? type;
  MetricResource? resource;

  @JsonKey(name: 'fetched_at')
  String? fetchedAt;

  @JsonKey(fromJson: _metricsFromJson, toJson: _metricsToJson)
  dynamic metrics;

  @JsonKey(name: 'display_name')
  String? displayName;

  MetricReport(this.id, this.type, this.resource, this.fetchedAt, this.metrics,
      this.displayName);

  factory MetricReport.fromJson(Map<String, dynamic> json) => _$MetricReportFromJson(json);
  Map<String, dynamic> toJson() => _$MetricReportToJson(this);


  static dynamic _metricsFromJson(Map<String, dynamic> json) {
    if (json.containsKey('values')) {
      return LinearMetrics.fromJson(json);
    }
    return Metrics.fromJson(json);
  }

  static Map<String, dynamic> _metricsToJson(dynamic metrics) {
    if (metrics is LinearMetrics) {
      return metrics.toJson();
    } else if (metrics is Metrics) {
      return metrics.toJson();
    }
    throw Exception('Unknown metrics type');
  }
}