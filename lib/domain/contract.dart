import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/client.dart';
import 'package:web_com/domain/company.dart';
import 'package:web_com/domain/contact.dart';
import 'package:web_com/domain/signer.dart';

import 'address.dart';
import 'bank_account.dart';
import 'currency.dart';

part 'contract.g.dart';

@JsonSerializable()
class Contract{
  int? id;
  String? number;
  Client? client;

  @JsonKey(name: 'client_id')
  int? clientId;

  Currency? currency;

  Company? company;

  @JsonKey(name: 'client_address')
  Address? clientAddress;

  @JsonKey(name: 'client_address_id')
  int? clientAddressId;

  @JsonKey(name: 'company_address')
  Address? companyAddress;

  @JsonKey(name: 'company_address_id')
  int? companyAddressId;

  @JsonKey(name: 'client_contact')
  Contact? clientContact;

  @JsonKey(name: 'client_contact_id')
  int? clientContactId;

  @JsonKey(name: 'company_bank_account')
  BankAccount? companyBankAccount;

  @JsonKey(name: 'company_bank_account_id')
  int? companyBankAccountId;

  @JsonKey(name: 'client_bank_account')
  BankAccount? clientBankAccount;

  @JsonKey(name: 'client_bank_account_id')
  int? clientBankAccountId;

  @JsonKey(name: 'client_signer')
  Signer? clientSigner;

  @JsonKey(name: 'client_signer_id')
  int? clientSignerId;

  @JsonKey(name: 'company_signer')
  Signer? companySigner;

  @JsonKey(name: 'company_signer_id')
  int? companySignerId;


  Contract(
      this.id,
      this.number,
      this.client,
      this.clientId,
      this.currency,
      this.company,
      this.clientAddress,
      this.clientAddressId,
      this.companyAddress,
      this.companyAddressId,
      this.clientContact,
      this.clientContactId,
      this.companyBankAccount,
      this.companyBankAccountId,
      this.clientBankAccount,
      this.clientBankAccountId,
      this.clientSigner,
      this.clientSignerId,
      this.companySigner,
      this.companySignerId);

  factory Contract.fromJson(Map<String, dynamic> json) => _$ContractFromJson(json);
  Map<String, dynamic> toJson() => _$ContractToJson(this);
}