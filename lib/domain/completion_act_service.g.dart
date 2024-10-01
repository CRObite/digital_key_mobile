// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_act_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletionActService _$CompletionActServiceFromJson(
        Map<String, dynamic> json) =>
    CompletionActService(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      (json['price'] as num?)?.toDouble(),
      (json['quantity'] as num?)?.toDouble(),
      (json['sum_nominal'] as num?)?.toDouble(),
      (json['sum_vat'] as num?)?.toDouble(),
      (json['completion_act_id'] as num?)?.toInt(),
      json['display_name'] as String?,
    );

Map<String, dynamic> _$CompletionActServiceToJson(
        CompletionActService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'sum_nominal': instance.sumNominal,
      'sum_vat': instance.sumVat,
      'completion_act_id': instance.completionActId,
      'display_name': instance.displayName,
    };
