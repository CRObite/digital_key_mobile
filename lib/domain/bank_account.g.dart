// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccount _$BankAccountFromJson(Map<String, dynamic> json) => BankAccount(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['iban'] as String?,
      json['uuid'] as String?,
      json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      (json['currency_id'] as num?)?.toInt(),
      json['bank'] == null
          ? null
          : Bank.fromJson(json['bank'] as Map<String, dynamic>),
      (json['bank_id'] as num?)?.toInt(),
      (json['client_id'] as num?)?.toInt(),
      (json['company_id'] as num?)?.toInt(),
      json['main_account'] as bool?,
    );

Map<String, dynamic> _$BankAccountToJson(BankAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iban': instance.iban,
      'uuid': instance.uuid,
      'currency': instance.currency,
      'currency_id': instance.currencyId,
      'bank': instance.bank,
      'bank_id': instance.bankId,
      'client_id': instance.clientId,
      'company_id': instance.companyId,
      'main_account': instance.mainAccount,
    };
