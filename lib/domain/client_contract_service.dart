import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/service.dart';
import 'package:web_com/domain/tariff.dart';

import 'client.dart';
import 'currency.dart';

part 'client_contract_service.g.dart';

@JsonSerializable()
class ClientContractService{
  int id;
  String? name;
  String? email;
  int? balance;

  @JsonKey(name: 'rads_account')
  String? radsAccount;

  @JsonKey(name: 'billing_setups')
  String? billingSetups;

  @JsonKey(name: 'account_budget')
  String? accountBudget;

  @JsonKey(name: 'ads_account')
  String? adsAccount;

  @JsonKey(name: 'client_account')
  String? clientAccount;

  @JsonKey(name: 'manager_account')
  String? managerAccount;

  @JsonKey(name: 'tariff_fee')
  int? tariffFee;

  String? website;
  Tariff? tariff;

  @JsonKey(name: 'tariff_id')
  int? tariffId;

  Client? client;

  @JsonKey(name: 'client_id')
  int? clientId;

  Currency? currency;

  @JsonKey(name: 'currency_id')
  int? currencyId;

  @JsonKey(name: 'contract_id')
  int? contractId;

  Service service;

  @JsonKey(name: 'service_id')
  int? serviceId;


  ClientContractService(
      this.id,
      this.name,
      this.email,
      this.balance,
      this.radsAccount,
      this.billingSetups,
      this.accountBudget,
      this.adsAccount,
      this.clientAccount,
      this.managerAccount,
      this.tariffFee,
      this.website,
      this.tariff,
      this.tariffId,
      this.client,
      this.clientId,
      this.currency,
      this.currencyId,
      this.contractId,
      this.service,
      this.serviceId);

  factory ClientContractService.fromJson(Map<String, dynamic> json) => _$ClientContractServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ClientContractServiceToJson(this);
}