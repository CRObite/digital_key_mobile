import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/attachment.dart';
import 'package:web_com/domain/bank_account.dart';
import 'package:web_com/domain/client.dart';
import 'package:web_com/domain/company.dart';
import 'package:web_com/domain/contract.dart';
import 'package:web_com/domain/currency.dart';
import 'package:web_com/domain/expiration.dart';
import 'package:web_com/domain/invoice_contract_service.dart';
import 'package:web_com/domain/invoice_service.dart';
import 'package:web_com/domain/operation_error.dart';
import 'package:web_com/domain/user.dart';

import '../config/invoice_status_enum.dart';
import '../config/invoice_type_enum.dart';


part 'invoice.g.dart';

@JsonSerializable()
class Invoice{
  int id;
  String? uuid;
  double? amount;

  @JsonKey(name: 'vat_amount')
  double? vatAmount;

  @JsonKey(name: 'fee_amount')
  double? feeAmount;
  String? comment;

  @JsonKey(name: 'document_number')
  String? documentNumber;
  String? knp;

  @JsonKey(name: 'invoice_at')
  String? invoiceAt;

  @JsonKey(name: 'sync_at')
  String? syncAt;

  @JsonKey(name: 'service_type',fromJson: invoiceTypeFromJson, toJson: invoiceTypeToJson)
  InvoiceType? serviceType;

  @JsonKey(fromJson: invoiceStatusFromJson, toJson: invoiceStatusToJson)
  InvoiceStatus? status;

  @JsonKey(name: 'fill_up_manually')
  bool? fillUpManually;
  Expiration? expiration;
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

  @JsonKey(name: 'created_by')
  User? createdBy;

  @JsonKey(name: 'created_by_id')
  int? createdById;

  @JsonKey(name: 'client_bank_account')
  BankAccount? clientBankAccount;

  @JsonKey(name: 'client_bank_account_id')
  int? clientBankAccountId;

  @JsonKey(name: 'company_bank_account')
  BankAccount? companyBankAccount;

  @JsonKey(name: 'company_bank_account_id')
  int? companyBankAccountId;
  Attachment? document;

  @JsonKey(name: 'document_id')
  int? documentId;

  @JsonKey(name: 'signed_document')
  Attachment? signedDocument;

  @JsonKey(name: 'signed_document_id')
  int? signedDocumentId;

  @JsonKey(name: 'invoice_contract_services')
  List<InvoiceContractService>? invoiceContractServices;

  @JsonKey(name: 'invoice_services')
  List<InvoiceService>? invoiceServices;
  List<OperationError>? errors;


  @JsonKey(includeFromJson: false, includeToJson: false)
  bool selected = false;


  Invoice(
      this.id,
      this.uuid,
      this.amount,
      this.vatAmount,
      this.feeAmount,
      this.comment,
      this.documentNumber,
      this.knp,
      this.invoiceAt,
      this.syncAt,
      this.serviceType,
      this.status,
      this.fillUpManually,
      this.expiration,
      this.client,
      this.clientId,
      this.company,
      this.companyId,
      this.contract,
      this.contractId,
      this.currency,
      this.currencyId,
      this.createdBy,
      this.createdById,
      this.clientBankAccount,
      this.clientBankAccountId,
      this.companyBankAccount,
      this.companyBankAccountId,
      this.document,
      this.documentId,
      this.signedDocument,
      this.signedDocumentId,
      this.invoiceContractServices,
      this.invoiceServices,
      this.errors);

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

}