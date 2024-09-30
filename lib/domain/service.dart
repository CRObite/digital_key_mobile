import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/config/provider_type_enum.dart';
import 'package:web_com/domain/attachment.dart';
import 'package:web_com/domain/currency.dart';
import 'package:web_com/domain/service_category.dart';


part 'service.g.dart';

@JsonSerializable()
class Service{
  int id;
  String? name;

  @JsonKey(name: 'provider_type', fromJson: providerTypeFromJson, toJson: providerTypeToJson)
  ProviderType? providerType;

  Attachment? logo;

  @JsonKey(name: 'logo_id')
  int? logoId;

  Currency? currency;

  @JsonKey(name: 'currency_id')
  int? currencyId;

  ServiceCategory? category;

  @JsonKey(name: 'category_id')
  int? categoryId;

  @JsonKey(name: 'display_name')
  String? displayName;


  Service(
      this.id,
      this.name,
      this.providerType,
      this.logo,
      this.logoId,
      this.currency,
      this.currencyId,
      this.category,
      this.categoryId,
      this.displayName);

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}