import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/client.dart';
import 'package:web_com/domain/company.dart';

import 'currency.dart';

part 'contract.g.dart';

@JsonSerializable()
class Contract{
  int id;
  bool? active;

  String? number;

  @JsonKey(name: 'closing_date')
  String? closingDate;

  @JsonKey(name: 'created_date')
  String? createdDate;

  Client? client;

  @JsonKey(name: 'client_id')
  int? clientId;

  Currency? currency;

  Company? company;

  Contract(
      this.id,
      this.active,
      this.number,
      this.closingDate,
      this.createdDate,
      this.client,
      this.clientId,
      this.currency,
      this.company);

  factory Contract.fromJson(Map<String, dynamic> json) => _$ContractFromJson(json);
  Map<String, dynamic> toJson() => _$ContractToJson(this);
}