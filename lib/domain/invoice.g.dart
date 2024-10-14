// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      (json['id'] as num).toInt(),
      json['uuid'] as String?,
      (json['amount'] as num?)?.toDouble(),
      (json['vat_amount'] as num?)?.toDouble(),
      (json['fee_amount'] as num?)?.toDouble(),
      json['comment'] as String?,
      json['document_number'] as String?,
      json['knp'] as String?,
      json['invoice_at'] as String?,
      json['sync_at'] as String?,
      invoiceTypeFromJson(json['service_type'] as String?),
      invoiceStatusFromJson(json['status'] as String?),
      json['fill_up_manually'] as bool?,
      json['expiration'] == null
          ? null
          : Expiration.fromJson(json['expiration'] as Map<String, dynamic>),
      json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
      (json['client_id'] as num?)?.toInt(),
      json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
      (json['company_id'] as num?)?.toInt(),
      json['contract'] == null
          ? null
          : Contract.fromJson(json['contract'] as Map<String, dynamic>),
      (json['contract_id'] as num?)?.toInt(),
      json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      (json['currency_id'] as num?)?.toInt(),
      json['created_by'] == null
          ? null
          : User.fromJson(json['created_by'] as Map<String, dynamic>),
      (json['created_by_id'] as num?)?.toInt(),
      json['client_bank_account'] == null
          ? null
          : BankAccount.fromJson(
              json['client_bank_account'] as Map<String, dynamic>),
      (json['client_bank_account_id'] as num?)?.toInt(),
      json['company_bank_account'] == null
          ? null
          : BankAccount.fromJson(
              json['company_bank_account'] as Map<String, dynamic>),
      (json['company_bank_account_id'] as num?)?.toInt(),
      json['document'] == null
          ? null
          : Attachment.fromJson(json['document'] as Map<String, dynamic>),
      (json['document_id'] as num?)?.toInt(),
      json['signed_document'] == null
          ? null
          : Attachment.fromJson(
              json['signed_document'] as Map<String, dynamic>),
      (json['signed_document_id'] as num?)?.toInt(),
      (json['invoice_contract_services'] as List<dynamic>?)
          ?.map(
              (e) => InvoiceContractService.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['invoice_services'] as List<dynamic>?)
          ?.map((e) => InvoiceService.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['errors'] as List<dynamic>?)
          ?.map((e) => OperationError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'amount': instance.amount,
      'vat_amount': instance.vatAmount,
      'fee_amount': instance.feeAmount,
      'comment': instance.comment,
      'document_number': instance.documentNumber,
      'knp': instance.knp,
      'invoice_at': instance.invoiceAt,
      'sync_at': instance.syncAt,
      'service_type': invoiceTypeToJson(instance.serviceType),
      'status': invoiceStatusToJson(instance.status),
      'fill_up_manually': instance.fillUpManually,
      'expiration': instance.expiration,
      'client': instance.client,
      'client_id': instance.clientId,
      'company': instance.company,
      'company_id': instance.companyId,
      'contract': instance.contract,
      'contract_id': instance.contractId,
      'currency': instance.currency,
      'currency_id': instance.currencyId,
      'created_by': instance.createdBy,
      'created_by_id': instance.createdById,
      'client_bank_account': instance.clientBankAccount,
      'client_bank_account_id': instance.clientBankAccountId,
      'company_bank_account': instance.companyBankAccount,
      'company_bank_account_id': instance.companyBankAccountId,
      'document': instance.document,
      'document_id': instance.documentId,
      'signed_document': instance.signedDocument,
      'signed_document_id': instance.signedDocumentId,
      'invoice_contract_services': instance.invoiceContractServices,
      'invoice_services': instance.invoiceServices,
      'errors': instance.errors,
    };
