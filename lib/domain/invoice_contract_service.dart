import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/client_contract_service.dart';

part 'invoice_contract_service.g.dart';

@JsonSerializable()
class InvoiceContractService{
  int id;
  double? amount;

  @JsonKey(name: 'invoice_id')
  int? invoiceId;

  @JsonKey(name: 'client_contract_service')
  ClientContractService? clientContractService;

  @JsonKey(name: 'client_contract_service_id')
  int? clientContractServiceId;

  @JsonKey(name: 'display_name')
  String? displayName;

  InvoiceContractService(
      this.id,
      this.amount,
      this.invoiceId,
      this.clientContractService,
      this.clientContractServiceId,
      this.displayName);

  factory InvoiceContractService.fromJson(Map<String, dynamic> json) => _$InvoiceContractServiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceContractServiceToJson(this);
}