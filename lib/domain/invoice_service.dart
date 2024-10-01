import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/service.dart';
import 'package:web_com/domain/tariff.dart';

import '../config/invoice_service_unit_enum.dart';
import 'nomenclature.dart';


part 'invoice_service.g.dart';

@JsonSerializable()
class InvoiceService{
  int id;
  String? description;
  String? code1c;

  @JsonKey(name: 'vatless_amount')
  int? vatlessAmount;

  @JsonKey(name: 'vat_amount')
  int? vatAmount;
  int? fee;

  @JsonKey(name: 'vatless_fee')
  int? vatlessFee;
  int? quantity;
  int? amount;

  @JsonKey(fromJson: invoiceServiceUnitFromJson,toJson: invoiceServiceUnitTypeToJson)
  InvoiceServiceUnit? unit;

  @JsonKey(name: 'invoice_id')
  int? invoiceId;
  Nomenclature? nomenclature;

  @JsonKey(name: 'nomenclature_id')
  int? nomenclatureId;
  Service? service;

  @JsonKey(name: 'service_id')
  int? serviceId;
  Tariff? tariff;

  @JsonKey(name: 'tariff_id')
  int? tariffId;

  @JsonKey(name: 'display_name')
  String? displayName;

  InvoiceService(
      this.id,
      this.description,
      this.code1c,
      this.vatlessAmount,
      this.vatAmount,
      this.fee,
      this.vatlessFee,
      this.quantity,
      this.amount,
      this.unit,
      this.invoiceId,
      this.nomenclature,
      this.nomenclatureId,
      this.service,
      this.serviceId,
      this.tariff,
      this.tariffId,
      this.displayName);

  factory InvoiceService.fromJson(Map<String, dynamic> json) => _$InvoiceServiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceServiceToJson(this);
}