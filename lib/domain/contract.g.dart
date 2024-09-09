// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contract _$ContractFromJson(Map<String, dynamic> json) => Contract(
      (json['id'] as num?)?.toInt(),
      json['number'] as String?,
      json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
      json['created_at'] as String?,
      (json['client_id'] as num?)?.toInt(),
      json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      json['expiration'] == null
          ? null
          : Expiration.fromJson(json['expiration'] as Map<String, dynamic>),
      json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
      json['contract_state'] == null
          ? null
          : ContractState.fromJson(
              json['contract_state'] as Map<String, dynamic>),
      json['client_address'] == null
          ? null
          : Address.fromJson(json['client_address'] as Map<String, dynamic>),
      (json['client_address_id'] as num?)?.toInt(),
      json['company_address'] == null
          ? null
          : Address.fromJson(json['company_address'] as Map<String, dynamic>),
      (json['company_address_id'] as num?)?.toInt(),
      json['client_contact'] == null
          ? null
          : Contact.fromJson(json['client_contact'] as Map<String, dynamic>),
      (json['client_contact_id'] as num?)?.toInt(),
      json['company_bank_account'] == null
          ? null
          : BankAccount.fromJson(
              json['company_bank_account'] as Map<String, dynamic>),
      (json['company_bank_account_id'] as num?)?.toInt(),
      json['client_bank_account'] == null
          ? null
          : BankAccount.fromJson(
              json['client_bank_account'] as Map<String, dynamic>),
      (json['client_bank_account_id'] as num?)?.toInt(),
      json['client_signer'] == null
          ? null
          : Signer.fromJson(json['client_signer'] as Map<String, dynamic>),
      (json['client_signer_id'] as num?)?.toInt(),
      json['company_signer'] == null
          ? null
          : Signer.fromJson(json['company_signer'] as Map<String, dynamic>),
      (json['company_signer_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'client': instance.client,
      'created_at': instance.createdAt,
      'client_id': instance.clientId,
      'currency': instance.currency,
      'expiration': instance.expiration,
      'company': instance.company,
      'contract_state': instance.contractState,
      'client_address': instance.clientAddress,
      'client_address_id': instance.clientAddressId,
      'company_address': instance.companyAddress,
      'company_address_id': instance.companyAddressId,
      'client_contact': instance.clientContact,
      'client_contact_id': instance.clientContactId,
      'company_bank_account': instance.companyBankAccount,
      'company_bank_account_id': instance.companyBankAccountId,
      'client_bank_account': instance.clientBankAccount,
      'client_bank_account_id': instance.clientBankAccountId,
      'client_signer': instance.clientSigner,
      'client_signer_id': instance.clientSignerId,
      'company_signer': instance.companySigner,
      'company_signer_id': instance.companySignerId,
    };
