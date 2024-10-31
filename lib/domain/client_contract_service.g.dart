// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_contract_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientContractService _$ClientContractServiceFromJson(
        Map<String, dynamic> json) =>
    ClientContractService(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['email'] as String?,
      (json['balance'] as num?)?.toDouble(),
      json['rads_account'] as String?,
      json['billing_setups'] as String?,
      json['account_budget'] as String?,
      json['ads_account'] as String?,
      json['client_account'] as String?,
      json['manager_account'] as String?,
      (json['tariff_fee'] as num?)?.toInt(),
      json['website'] as String?,
      json['tariff'] == null
          ? null
          : Tariff.fromJson(json['tariff'] as Map<String, dynamic>),
      (json['tariff_id'] as num?)?.toInt(),
      json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
      (json['client_id'] as num?)?.toInt(),
      json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      (json['currency_id'] as num?)?.toInt(),
      (json['contract_id'] as num?)?.toInt(),
      json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      (json['service_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ClientContractServiceToJson(
        ClientContractService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'balance': instance.balance,
      'rads_account': instance.radsAccount,
      'billing_setups': instance.billingSetups,
      'account_budget': instance.accountBudget,
      'ads_account': instance.adsAccount,
      'client_account': instance.clientAccount,
      'manager_account': instance.managerAccount,
      'tariff_fee': instance.tariffFee,
      'website': instance.website,
      'tariff': instance.tariff,
      'tariff_id': instance.tariffId,
      'client': instance.client,
      'client_id': instance.clientId,
      'currency': instance.currency,
      'currency_id': instance.currencyId,
      'contract_id': instance.contractId,
      'service': instance.service,
      'service_id': instance.serviceId,
    };
