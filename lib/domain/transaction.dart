import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/config/transaction_status_enum.dart';
import 'package:web_com/domain/currency.dart';
import 'package:web_com/domain/operation_error.dart';
import 'package:web_com/domain/service_operation.dart';

import 'invoice.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction{
  int id;

  @JsonKey(name: 'statement_id')
  int? statementId;

  @JsonKey(name: 'account_recipient')
  String? accountRecipient;

  @JsonKey(name: 'account_sender')
  String? accountSender;

  @JsonKey(name: 'amount_sender')
  double? amountSender;

  @JsonKey(name: 'knp_code')
  String? knpCode;

  @JsonKey(name: 'mfo_recipient')
  String? mfoRecipient;

  @JsonKey(name: 'mfo_sender')
  String? mfoSender;

  @JsonKey(name: 'name_recipient')
  String? nameRecipient;

  @JsonKey(name: 'name_sender')
  String? nameSender;

  @JsonKey(name: 'payment_purpose')
  String? paymentPurpose;

  @JsonKey(name: 'payment_purpose_recipient')
  String? paymentPurposeRecipient;

  @JsonKey(name: 'payment_purpose_sender')
  String? paymentPurposeSender;

  @JsonKey(name: 'rnn_recipient')
  String? rnnRecipient;

  @JsonKey(name: 'rnn_sender')
  String? rnnSender;

  @JsonKey(name: 'statement_reference')
  String? statementReference;

  @JsonKey(name: 'statement_date')
  String? statementDate;

  @JsonKey(fromJson: transactionStatusFromJson, toJson: transactionStatusToJson)
  TransactionStatus? status;

  Currency? currency;

  @JsonKey(name: 'currency_id')
  int? currencyId;

  List<Invoice>? invoices;

  List<OperationError>? errors;

  @JsonKey(name: 'service_operations')
  List<ServiceOperation>? serviceOperations;

  Transaction(
      this.id,
      this.statementId,
      this.accountRecipient,
      this.accountSender,
      this.amountSender,
      this.knpCode,
      this.mfoRecipient,
      this.mfoSender,
      this.nameRecipient,
      this.nameSender,
      this.paymentPurpose,
      this.paymentPurposeRecipient,
      this.paymentPurposeSender,
      this.rnnRecipient,
      this.rnnSender,
      this.statementReference,
      this.statementDate,
      this.status,
      this.currency,
      this.currencyId,
      this.invoices,
      this.errors,
      this.serviceOperations);


  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}