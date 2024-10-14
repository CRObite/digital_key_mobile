import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/attachment.dart';
import 'package:web_com/domain/client.dart';
import 'package:web_com/domain/company.dart';
import 'package:web_com/domain/completion_act_service.dart';
import 'package:web_com/domain/contract.dart';
import 'package:web_com/domain/currency.dart';
import 'package:web_com/domain/invoice.dart';
import 'package:web_com/domain/operation_error.dart';
import 'package:web_com/domain/user.dart';

import '../config/completion_act_status_enum.dart';


part 'completion_act.g.dart';

@JsonSerializable()
class CompletionAct{
  int? id;
  String? uuid;
  String? name;
  String? code;

  @JsonKey(name: 'document_at')
  String? documentAt;

  @JsonKey(name: 'sync_at')
  String? syncAt;
  double? sum;

  @JsonKey(fromJson: completionActStatusFromJson, toJson: completionActStatusToJson)
  CompletionActStatus? status;
  Currency? currency;

  @JsonKey(name: 'currency_id')
  int? currencyId;
  Invoice? invoice;

  @JsonKey(name: 'invoice_id')
  int? invoiceId;
  Client? client;

  @JsonKey(name: 'client_id')
  int? clientId;
  Company? company;

  @JsonKey(name: 'company_id')
  int? companyId;
  Contract? contract;

  @JsonKey(name: 'created_by')
  User? createdBy;

  @JsonKey(name: 'created_by_id')
  int? createdById;

  @JsonKey(name: 'contract_id')
  int? contractId;
  Attachment? document;

  @JsonKey(name: 'document_id')
  int? documentId;

  @JsonKey(name: 'signed_document')
  Attachment? signedDocument;

  @JsonKey(name: 'signed_document_id')
  int? signedDocumentId;

  @JsonKey(name: 'completion_act_services')
  List<CompletionActService>? completionActServices;
  List<OperationError>? errors;


  CompletionAct(
      this.id,
      this.uuid,
      this.name,
      this.code,
      this.documentAt,
      this.syncAt,
      this.sum,
      this.status,
      this.currency,
      this.currencyId,
      this.invoice,
      this.invoiceId,
      this.client,
      this.clientId,
      this.company,
      this.companyId,
      this.contract,
      this.createdBy,
      this.createdById,
      this.contractId,
      this.document,
      this.documentId,
      this.signedDocument,
      this.signedDocumentId,
      this.completionActServices,
      this.errors);

  factory CompletionAct.fromJson(Map<String, dynamic> json) => _$CompletionActFromJson(json);
  Map<String, dynamic> toJson() => _$CompletionActToJson(this);
}