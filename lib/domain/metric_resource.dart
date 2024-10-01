import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/attachment.dart';
import 'package:web_com/domain/client.dart';
import 'package:web_com/domain/client_contract_service.dart';

import 'service.dart';
import '../config/metrics_report_type_enum.dart';

part 'metric_resource.g.dart';

@JsonSerializable()

class MetricResource{
  int id;

  @JsonKey(name: 'resource_id')
  String? resourceId;
  String? name;

  @JsonKey(name: 'resource_name')
  String? resourceName;
  String? status;
  MetricsReportType?	type;

  @JsonKey(name: 'start_date')
  String? startDate;

  @JsonKey(name: 'cabinet_id')
  String? cabinetId;
  Attachment? logo;
  Client? client;

  @JsonKey(name: 'client_id')
  int? clientId;
  Service? service;

  @JsonKey(name: 'service_id')
  int? serviceId;

  @JsonKey(name: 'client_contract_service')
  ClientContractService? clientContractService;

  @JsonKey(name: 'client_contract_service_id')
  int? clientContractServiceId;

  @JsonKey(name: 'display_name')
  String? displayName;

  MetricResource(
      this.id,
      this.resourceId,
      this.name,
      this.resourceName,
      this.status,
      this.type,
      this.startDate,
      this.cabinetId,
      this.logo,
      this.client,
      this.clientId,
      this.service,
      this.serviceId,
      this.clientContractService,
      this.clientContractServiceId,
      this.displayName);

  factory MetricResource.fromJson(Map<String, dynamic> json) => _$MetricResourceFromJson(json);
  Map<String, dynamic> toJson() => _$MetricResourceToJson(this);
}