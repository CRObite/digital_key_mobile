// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electronic_invoice_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectronicInvoiceService _$ElectronicInvoiceServiceFromJson(
        Map<String, dynamic> json) =>
    ElectronicInvoiceService(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      (json['sum_vat'] as num?)?.toDouble(),
      (json['sum_nominal'] as num?)?.toDouble(),
      (json['quantity'] as num?)?.toInt(),
      (json['price'] as num?)?.toDouble(),
      $enumDecodeNullable(_$InvoiceServiceUnitEnumMap, json['unit']),
      (json['electronic_invoice_id'] as num?)?.toInt(),
      json['display_name'] as String?,
    );

Map<String, dynamic> _$ElectronicInvoiceServiceToJson(
        ElectronicInvoiceService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sum_vat': instance.sumVat,
      'sum_nominal': instance.sumNominal,
      'quantity': instance.quantity,
      'price': instance.price,
      'unit': _$InvoiceServiceUnitEnumMap[instance.unit],
      'electronic_invoice_id': instance.electronicInvoiceId,
      'display_name': instance.displayName,
    };

const _$InvoiceServiceUnitEnumMap = {
  InvoiceServiceUnit.PERCENT: 'PERCENT',
  InvoiceServiceUnit.SERVICE: 'SERVICE',
  InvoiceServiceUnit.HOUR: 'HOUR',
  InvoiceServiceUnit.UNIT: 'UNIT',
};
