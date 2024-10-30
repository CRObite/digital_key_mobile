// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_operation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceOperation _$ServiceOperationFromJson(Map<String, dynamic> json) =>
    ServiceOperation(
      (json['id'] as num?)?.toInt(),
      (json['amount'] as num?)?.toDouble(),
      (json['rate'] as num?)?.toDouble(),
      json['executed_at'] as String?,
      json['active'] as bool?,
      $enumDecodeNullable(_$ServiceOperationPayformEnumMap, json['pay_form']),
      $enumDecodeNullable(_$ServiceOperationStatusEnumMap, json['status']),
      $enumDecodeNullable(_$ServiceOperationTypeEnumMap, json['type']),
      json['created_by'] == null
          ? null
          : User.fromJson(json['created_by'] as Map<String, dynamic>),
      (json['created_by_id'] as num?)?.toInt(),
      json['contract'] == null
          ? null
          : Contract.fromJson(json['contract'] as Map<String, dynamic>),
      (json['contract_id'] as num?)?.toInt(),
      json['from_service'] == null
          ? null
          : ClientContractService.fromJson(
              json['from_service'] as Map<String, dynamic>),
      (json['from_service_id'] as num?)?.toInt(),
      json['to_service'] == null
          ? null
          : ClientContractService.fromJson(
              json['to_service'] as Map<String, dynamic>),
      (json['to_service_id'] as num?)?.toInt(),
      json['account_manager'] == null
          ? null
          : User.fromJson(json['account_manager'] as Map<String, dynamic>),
      (json['account_manager_id'] as num?)?.toInt(),
      json['invoice'] == null
          ? null
          : Invoice.fromJson(json['invoice'] as Map<String, dynamic>),
      (json['invoice_id'] as num?)?.toInt(),
      json['transaction'] == null
          ? null
          : Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
      (json['transaction_id'] as num?)?.toInt(),
      (json['errors'] as List<dynamic>?)
          ?.map((e) => OperationError.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['display_name'] as String?,
    );

Map<String, dynamic> _$ServiceOperationToJson(ServiceOperation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'rate': instance.rate,
      'executed_at': instance.executedAt,
      'active': instance.active,
      'pay_form': _$ServiceOperationPayformEnumMap[instance.payForm],
      'status': _$ServiceOperationStatusEnumMap[instance.status],
      'type': _$ServiceOperationTypeEnumMap[instance.type],
      'created_by': instance.createdBy,
      'created_by_id': instance.createdById,
      'contract': instance.contract,
      'contract_id': instance.contractId,
      'from_service': instance.fromService,
      'from_service_id': instance.fromServiceId,
      'to_service': instance.toService,
      'to_service_id': instance.toServiceId,
      'account_manager': instance.accountManager,
      'account_manager_id': instance.accountManagerId,
      'invoice': instance.invoice,
      'invoice_id': instance.invoiceId,
      'transaction': instance.transaction,
      'transaction_id': instance.transactionId,
      'errors': instance.errors,
      'display_name': instance.displayName,
    };

const _$ServiceOperationPayformEnumMap = {
  ServiceOperationPayform.PRE_PAYMENT: 'PRE_PAYMENT',
  ServiceOperationPayform.POST_PAYMENT: 'POST_PAYMENT',
  ServiceOperationPayform.MIXED: 'MIXED',
};

const _$ServiceOperationStatusEnumMap = {
  ServiceOperationStatus.NEW: 'NEW',
  ServiceOperationStatus.FINISHED: 'FINISHED',
  ServiceOperationStatus.MANUALLY_EXECUTED: 'MANUALLY_EXECUTED',
  ServiceOperationStatus.FORBIDDEN: 'FORBIDDEN',
  ServiceOperationStatus.DELETION: 'DELETION',
  ServiceOperationStatus.ERROR: 'ERROR',
};

const _$ServiceOperationTypeEnumMap = {
  ServiceOperationType.TRANSFER: 'TRANSFER',
  ServiceOperationType.REFUND: 'REFUND',
  ServiceOperationType.FUND: 'FUND',
};
