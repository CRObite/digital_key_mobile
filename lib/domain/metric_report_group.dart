import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/attachment.dart';
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
  Metrics? metrics;
  List<Service>? services;

  MetricReportGroup(
      this.id, this.name, this.logo, this.content, this.metrics, this.services);

  factory MetricReportGroup.fromJson(Map<String, dynamic> json) => _$MetricReportGroupFromJson(json);
  Map<String, dynamic> toJson() => _$MetricReportGroupToJson(this);
}