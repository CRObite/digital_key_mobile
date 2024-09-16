
import 'package:json_annotation/json_annotation.dart';

import 'attachment.dart';

part 'currency.g.dart';

@JsonSerializable()
class Currency{
  int? id;
  String? code;
  String? name;
  Attachment? logo;

  Currency(this.id, this.code, this.name, this.logo);

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}