import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/config/invoice_service_unit_enum.dart';

part 'electronic_invoice_service.g.dart';

@JsonSerializable()
class ElectronicInvoiceService{
  int id;
  String? name;

  @JsonKey(name: 'sum_vat')
  double? sumVat;

  @JsonKey(name: 'sum_nominal')
  double? sumNominal;
  int? quantity;
  double? price;
  InvoiceServiceUnit? unit;

  @JsonKey(name: 'electronic_invoice_id')
  int? electronicInvoiceId;

  @JsonKey(name: 'display_name')
  String? displayName;

  ElectronicInvoiceService(
      this.id,
      this.name,
      this.sumVat,
      this.sumNominal,
      this.quantity,
      this.price,
      this.unit,
      this.electronicInvoiceId,
      this.displayName);

  factory ElectronicInvoiceService.fromJson(Map<String, dynamic> json) => _$ElectronicInvoiceServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ElectronicInvoiceServiceToJson(this);
}