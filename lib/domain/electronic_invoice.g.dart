// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electronic_invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectronicInvoice _$ElectronicInvoiceFromJson(Map<String, dynamic> json) =>
    ElectronicInvoice(
      (json['id'] as num).toInt(),
      json['uuid'] as String?,
      json['identificator'] as String?,
      json['worker'] as String?,
      (json['sum'] as num?)?.toDouble(),
      json['document_number'] as String?,
      json['act_number'] as String?,
      json['document_at'] as String?,
      json['act_at'] as String?,
      json['sync_at'] as String?,
      electronicInvoiceTypeFromJson(json['type'] as String?),
      electronicInvoiceDirectionFromJson(json['direction'] as String?),
      electronicInvoiceStatusFromJson(json['status'] as String?),
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
      json['document'] == null
          ? null
          : Attachment.fromJson(json['document'] as Map<String, dynamic>),
      (json['document_id'] as num?)?.toInt(),
      (json['electronic_invoice_services'] as List<dynamic>?)
          ?.map((e) =>
              ElectronicInvoiceService.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['errors'] as List<dynamic>?)
          ?.map((e) => OperationError.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ElectronicInvoiceToJson(ElectronicInvoice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'identificator': instance.identificator,
      'worker': instance.worker,
      'sum': instance.sum,
      'document_number': instance.documentNumber,
      'act_number': instance.actNumber,
      'document_at': instance.documentAt,
      'act_at': instance.actAt,
      'sync_at': instance.syncAt,
      'type': electronicInvoiceTypeToJson(instance.type),
      'direction': electronicInvoiceDirectionToJson(instance.direction),
      'status': electronicInvoiceStatusTypeToJson(instance.status),
      'client': instance.client,
      'client_id': instance.clientId,
      'company': instance.company,
      'company_id': instance.companyId,
      'contract': instance.contract,
      'contract_id': instance.contractId,
      'currency': instance.currency,
      'currency_id': instance.currencyId,
      'document': instance.document,
      'document_id': instance.documentId,
      'electronic_invoice_services': instance.electronicInvoiceServices,
      'errors': instance.errors,
    };
