// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationError _$OperationErrorFromJson(Map<String, dynamic> json) =>
    OperationError(
      (json['id'] as num).toInt(),
      json['message'] as String?,
      (json['electronic_invoice_id'] as num?)?.toInt(),
      (json['service_operation_id'] as num?)?.toInt(),
      (json['completion_act_id'] as num?)?.toInt(),
      (json['transaction_id'] as num?)?.toInt(),
      (json['invoice_id'] as num?)?.toInt(),
      (json['details'] as List<dynamic>?)
          ?.map((e) => ErrorDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['display_name'] as String?,
    );

Map<String, dynamic> _$OperationErrorToJson(OperationError instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'electronic_invoice_id': instance.electronicInvoiceId,
      'service_operation_id': instance.serviceOperationId,
      'completion_act_id': instance.completionActId,
      'transaction_id': instance.transactionId,
      'invoice_id': instance.invoiceId,
      'details': instance.details,
      'display_name': instance.displayName,
    };
