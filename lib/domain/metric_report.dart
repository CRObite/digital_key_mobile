import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/metric_resource.dart';
import 'package:web_com/domain/metrics.dart';

import '../config/metrics_report_type_enum.dart';

part 'metric_report.g.dart';

@JsonSerializable()
class MetricReport{
  int id;

  @JsonKey(fromJson: metricsReportTypeFromJson,toJson: metricsReportTypeToJson)
  MetricsReportType? type;
  MetricResource? resource;

  @JsonKey(name: 'fetched_at')
  String? fetchedAt;
  Metrics? metrics;

  @JsonKey(name: 'display_name')
  String? displayName;

  MetricReport(this.id, this.type, this.resource, this.fetchedAt, this.metrics,
      this.displayName);

  factory MetricReport.fromJson(Map<String, dynamic> json) => _$MetricReportFromJson(json);
  Map<String, dynamic> toJson() => _$MetricReportToJson(this);
}