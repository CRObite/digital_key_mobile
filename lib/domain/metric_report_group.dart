import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/attachment.dart';
import 'package:web_com/domain/linear_metrics.dart';
import 'package:web_com/domain/metric_report.dart';
import 'package:web_com/domain/metrics.dart';
import 'package:web_com/domain/service.dart';


part 'metric_report_group.g.dart';

@JsonSerializable()
class MetricReportGroup{
  int id;
  String? name;
  Attachment? logo;
  List<MetricReport>? content;

  @JsonKey(fromJson: _metricsFromJson, toJson: _metricsToJson)
  dynamic metrics;
  List<Service>? services;

  MetricReportGroup(
      this.id, this.name, this.logo, this.content, this.metrics, this.services);

  factory MetricReportGroup.fromJson(Map<String, dynamic> json) => _$MetricReportGroupFromJson(json);
  Map<String, dynamic> toJson() => _$MetricReportGroupToJson(this);


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