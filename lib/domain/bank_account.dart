import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/currency.dart';

import 'bank.dart';

class BankAccount{

  int id;
  String? name;
  String? iban;
  String? uuid;
  Currency? currency;

  @JsonKey(name: 'currency_id')
  int? currencyId;
  Bank? bank;

  @JsonKey(name: 'bank_id')
  int? bankId;

  @JsonKey(name: 'client_id')
  int? clientId;

  @JsonKey(name: 'company_id')
  int? companyId;

  BankAccount(this.id, this.name, this.iban, this.uuid, this.currency,
      this.currencyId, this.bank, this.bankId, this.clientId, this.companyId);

}