import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/error_details.dart';

part 'operation_error.g.dart';

@JsonSerializable()
class OperationError{
  int id;
  String? message;

  @JsonKey(name: 'electronic_invoice_id')
  int? electronicInvoiceId;

  @JsonKey(name: 'service_operation_id')
  int? serviceOperationId;

  @JsonKey(name: 'completion_act_id')
  int? completionActId;

  @JsonKey(name: 'transaction_id')
  int? transactionId;

  @JsonKey(name: 'invoice_id')
  int? invoiceId;
  List<ErrorDetails>? details;

  @JsonKey(name: 'display_name')
  String? displayName;


  OperationError(
      this.id,
      this.message,
      this.electronicInvoiceId,
      this.serviceOperationId,
      this.completionActId,
      this.transactionId,
      this.invoiceId,
      this.details,
      this.displayName);

  factory OperationError.fromJson(Map<String, dynamic> json) => _$OperationErrorFromJson(json);
  Map<String, dynamic> toJson() => _$OperationErrorToJson(this);
}