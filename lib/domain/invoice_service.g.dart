// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceService _$InvoiceServiceFromJson(Map<String, dynamic> json) =>
    InvoiceService(
      (json['id'] as num).toInt(),
      json['description'] as String?,
      json['code1c'] as String?,
      (json['vatless_amount'] as num?)?.toInt(),
      (json['vat_amount'] as num?)?.toInt(),
      (json['fee'] as num?)?.toInt(),
      (json['vatless_fee'] as num?)?.toInt(),
      (json['quantity'] as num?)?.toInt(),
      (json['amount'] as num?)?.toInt(),
      invoiceServiceUnitFromJson(json['unit'] as String?),
      (json['invoice_id'] as num?)?.toInt(),
      json['nomenclature'] == null
          ? null
          : Nomenclature.fromJson(json['nomenclature'] as Map<String, dynamic>),
      (json['nomenclature_id'] as num?)?.toInt(),
      json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      (json['service_id'] as num?)?.toInt(),
      json['tariff'] == null
          ? null
          : Tariff.fromJson(json['tariff'] as Map<String, dynamic>),
      (json['tariff_id'] as num?)?.toInt(),
      json['display_name'] as String?,
    );

Map<String, dynamic> _$InvoiceServiceToJson(InvoiceService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'code1c': instance.code1c,
      'vatless_amount': instance.vatlessAmount,
      'vat_amount': instance.vatAmount,
      'fee': instance.fee,
      'vatless_fee': instance.vatlessFee,
      'quantity': instance.quantity,
      'amount': instance.amount,
      'unit': invoiceServiceUnitTypeToJson(instance.unit),
      'invoice_id': instance.invoiceId,
      'nomenclature': instance.nomenclature,
      'nomenclature_id': instance.nomenclatureId,
      'service': instance.service,
      'service_id': instance.serviceId,
      'tariff': instance.tariff,
      'tariff_id': instance.tariffId,
      'display_name': instance.displayName,
    };
