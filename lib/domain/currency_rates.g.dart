// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_rates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyRates _$CurrencyRatesFromJson(Map<String, dynamic> json) =>
    CurrencyRates(
      (json['id'] as num).toInt(),
      (json['rate'] as num?)?.toDouble(),
      Currency.fromJson(json['currency'] as Map<String, dynamic>),
      (json['currency_id'] as num).toInt(),
    );

Map<String, dynamic> _$CurrencyRatesToJson(CurrencyRates instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rate': instance.rate,
      'currency': instance.currency,
      'currency_id': instance.currencyId,
    };
