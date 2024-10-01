// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_act.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletionAct _$CompletionActFromJson(Map<String, dynamic> json) =>
    CompletionAct(
      (json['id'] as num?)?.toInt(),
      json['uuid'] as String?,
      json['name'] as String?,
      json['code'] as String?,
      json['document_at'] as String?,
      json['sync_at'] as String?,
      (json['sum'] as num?)?.toDouble(),
      completionActStatusFromJson(json['status'] as String?),
      json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      (json['currency_id'] as num?)?.toInt(),
      json['invoice'] == null
          ? null
          : Invoice.fromJson(json['invoice'] as Map<String, dynamic>),
      (json['invoice_id'] as num?)?.toInt(),
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
      json['document'] == null
          ? null
          : Attachment.fromJson(json['document'] as Map<String, dynamic>),
      (json['document_id'] as num?)?.toInt(),
      json['signed_document'] == null
          ? null
          : Attachment.fromJson(
              json['signed_document'] as Map<String, dynamic>),
      (json['signed_document_id'] as num?)?.toInt(),
      (json['completion_act_services'] as List<dynamic>?)
          ?.map((e) => CompletionActService.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['errors'] as List<dynamic>?)
          ?.map((e) => OperationError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompletionActToJson(CompletionAct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'name': instance.name,
      'code': instance.code,
      'document_at': instance.documentAt,
      'sync_at': instance.syncAt,
      'sum': instance.sum,
      'status': completionActStatusToJson(instance.status),
      'currency': instance.currency,
      'currency_id': instance.currencyId,
      'invoice': instance.invoice,
      'invoice_id': instance.invoiceId,
      'client': instance.client,
      'client_id': instance.clientId,
      'company': instance.company,
      'company_id': instance.companyId,
      'contract': instance.contract,
      'contract_id': instance.contractId,
      'document': instance.document,
      'document_id': instance.documentId,
      'signed_document': instance.signedDocument,
      'signed_document_id': instance.signedDocumentId,
      'completion_act_services': instance.completionActServices,
      'errors': instance.errors,
    };
