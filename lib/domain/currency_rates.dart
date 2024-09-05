import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';

part 'currency_rates.g.dart';

@JsonSerializable()
class CurrencyRates{
  int id;
  double? rate;
  Currency currency;

  @JsonKey(name: 'currency_id')
  int currencyId;

  CurrencyRates(this.id, this.rate, this.currency, this.currencyId);

  factory CurrencyRates.fromJson(Map<String, dynamic> json) => _$CurrencyRatesFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyRatesToJson(this);
}

