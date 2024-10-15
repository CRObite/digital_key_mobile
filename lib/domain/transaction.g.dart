// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      (json['id'] as num).toInt(),
      json['active'] as bool?,
      (json['statement_id'] as num?)?.toInt(),
      json['account_recipient'] as String?,
      json['account_sender'] as String?,
      (json['amount_sender'] as num?)?.toDouble(),
      json['knp_code'] as String?,
      json['mfo_recipient'] as String?,
      json['mfo_sender'] as String?,
      json['name_recipient'] as String?,
      json['name_sender'] as String?,
      json['payment_purpose'] as String?,
      json['payment_purpose_recipient'] as String?,
      json['payment_purpose_sender'] as String?,
      json['rnn_recipient'] as String?,
      json['rnn_sender'] as String?,
      json['statement_reference'] as String?,
      json['statement_date'] as String?,
      transactionStatusFromJson(json['status'] as String?),
      json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      (json['currency_id'] as num?)?.toInt(),
      (json['invoices'] as List<dynamic>?)
          ?.map((e) => Invoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['errors'] as List<dynamic>?)
          ?.map((e) => OperationError.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['service_operations'] as List<dynamic>?)
          ?.map((e) => ServiceOperation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'statement_id': instance.statementId,
      'account_recipient': instance.accountRecipient,
      'account_sender': instance.accountSender,
      'amount_sender': instance.amountSender,
      'knp_code': instance.knpCode,
      'mfo_recipient': instance.mfoRecipient,
      'mfo_sender': instance.mfoSender,
      'name_recipient': instance.nameRecipient,
      'name_sender': instance.nameSender,
      'payment_purpose': instance.paymentPurpose,
      'payment_purpose_recipient': instance.paymentPurposeRecipient,
      'payment_purpose_sender': instance.paymentPurposeSender,
      'rnn_recipient': instance.rnnRecipient,
      'rnn_sender': instance.rnnSender,
      'statement_reference': instance.statementReference,
      'statement_date': instance.statementDate,
      'status': transactionStatusToJson(instance.status),
      'currency': instance.currency,
      'currency_id': instance.currencyId,
      'invoices': instance.invoices,
      'errors': instance.errors,
      'service_operations': instance.serviceOperations,
    };
