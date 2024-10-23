import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/config/service_operation_type_enum.dart';
import 'package:web_com/domain/client_contract_service.dart';
import 'package:web_com/domain/invoice.dart';
import 'package:web_com/domain/operation_error.dart';
import 'package:web_com/domain/transaction.dart';
import 'package:web_com/domain/user.dart';

import '../config/service_operation_payform_enum.dart';
import '../config/service_operation_status_enum.dart';
import 'contract.dart';


part 'service_operation.g.dart';

@JsonSerializable()
class ServiceOperation{
  int id;
  double? amount;
  double? rate;

  @JsonKey(name: 'executed_at')
  String? executedAt;

  bool active;

  @JsonKey(name: 'pay_form')
  ServiceOperationPayform? payForm;
  ServiceOperationStatus? status;
  ServiceOperationType? type;

  @JsonKey(name: 'created_by')
  User? createdBy;

  @JsonKey(name: 'created_by_id')
  int? createdById;
  Contract? contract;

  @JsonKey(name: 'contract_id')
  int? contractId;

  @JsonKey(name: 'from_service')
  ClientContractService? fromService;

  @JsonKey(name: 'from_service_id')
  int? fromServiceId;

  @JsonKey(name: 'to_service')
  ClientContractService? toService;

  @JsonKey(name: 'to_service_id')
  int? toServiceId;

  @JsonKey(name: 'account_manager')
  User? accountManager;

  @JsonKey(name: 'account_manager_id')
  int? accountManagerId;
  Invoice? invoice;

  @JsonKey(name: 'invoice_id')
  int? invoiceId;

  Transaction? transaction;

  @JsonKey(name: 'transaction_id')
  int? transactionId;

  List<OperationError>? errors;

  @JsonKey(name: 'display_name')
  String? displayName;


  ServiceOperation(
      this.id,
      this.amount,
      this.rate,
      this.executedAt,
      this.active,
      this.payForm,
      this.status,
      this.type,
      this.createdBy,
      this.createdById,
      this.contract,
      this.contractId,
      this.fromService,
      this.fromServiceId,
      this.toService,
      this.toServiceId,
      this.accountManager,
      this.accountManagerId,
      this.invoice,
      this.invoiceId,
      this.transaction,
      this.transactionId,
      this.errors,
      this.displayName);

  factory ServiceOperation.fromJson(Map<String, dynamic> json) => _$ServiceOperationFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceOperationToJson(this);
}