// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_contract_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceContractService _$InvoiceContractServiceFromJson(
        Map<String, dynamic> json) =>
    InvoiceContractService(
      (json['id'] as num).toInt(),
      (json['amount'] as num?)?.toDouble(),
      (json['invoice_id'] as num?)?.toInt(),
      json['client_contract_service'] == null
          ? null
          : ClientContractService.fromJson(
              json['client_contract_service'] as Map<String, dynamic>),
      (json['client_contract_service_id'] as num?)?.toInt(),
      json['display_name'] as String?,
    );

Map<String, dynamic> _$InvoiceContractServiceToJson(
        InvoiceContractService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'invoice_id': instance.invoiceId,
      'client_contract_service': instance.clientContractService,
      'client_contract_service_id': instance.clientContractServiceId,
      'display_name': instance.displayName,
    };
