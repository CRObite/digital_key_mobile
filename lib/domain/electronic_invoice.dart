import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/config/electronic_invoice_status_enum.dart';
import 'package:web_com/domain/attachment.dart';
import 'package:web_com/domain/contract.dart';
import 'package:web_com/domain/currency.dart';
import 'package:web_com/domain/electronic_invoice_service.dart';
import 'package:web_com/domain/operation_error.dart';

import '../config/electronic_invoice_direction_enum.dart';
import '../config/electronic_invoice_type_enum.dart';
import 'client.dart';
import 'company.dart';

part 'electronic_invoice.g.dart';

@JsonSerializable()
class ElectronicInvoice{
  int id;
  String? uuid;
  String? identificator;
  String? worker;
  double? sum;

  @JsonKey(name: 'document_number')
  String? documentNumber;

  @JsonKey(name: 'act_number')
  String? actNumber;

  @JsonKey(name: 'document_at')
  String? documentAt;

  @JsonKey(name: 'act_at')
  String? actAt;

  @JsonKey(name: 'sync_at')
  String? syncAt;

  @JsonKey(fromJson: electronicInvoiceTypeFromJson, toJson: electronicInvoiceTypeToJson)
  ElectronicInvoiceType? type;

  @JsonKey(fromJson: electronicInvoiceDirectionFromJson, toJson: electronicInvoiceDirectionToJson)
  ElectronicInvoiceDirection? direction;

  @JsonKey(fromJson: electronicInvoiceStatusFromJson, toJson: electronicInvoiceStatusTypeToJson)
  ElectronicInvoiceStatus? status;
  Client? client;

  @JsonKey(name: 'client_id')
  int? clientId;
  Company? company;

  @JsonKey(name: 'company_id')
  int? companyId;
  Contract? contract;

  @JsonKey(name: 'contract_id')
  int? contractId;

  Currency? currency;

  @JsonKey(name: 'currency_id')
  int? currencyId;

  Attachment? document;

  @JsonKey(name: 'document_id')
  int? documentId;

  @JsonKey(name: 'electronic_invoice_services')
  List<ElectronicInvoiceService>? electronicInvoiceServices;
  List<OperationError>? errors;

  ElectronicInvoice(
      this.id,
      this.uuid,
      this.identificator,
      this.worker,
      this.sum,
      this.documentNumber,
      this.actNumber,
      this.documentAt,
      this.actAt,
      this.syncAt,
      this.type,
      this.direction,
      this.status,
      this.client,
      this.clientId,
      this.company,
      this.companyId,
      this.contract,
      this.contractId,
      this.currency,
      this.currencyId,
      this.document,
      this.documentId,
      this.electronicInvoiceServices,
      this.errors);

  factory ElectronicInvoice.fromJson(Map<String, dynamic> json) => _$ElectronicInvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$ElectronicInvoiceToJson(this);
}