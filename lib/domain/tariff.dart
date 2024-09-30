import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/contract_type.dart';


part 'tariff.g.dart';

@JsonSerializable()
class Tariff{
  int id;
  String? name;
  int? max;
  int? min;

  @JsonKey(name: 'is_percent')
  bool? isPercent;
  int? price;

  @JsonKey(name: 'contract_type')
  ContractType? contractType;

  @JsonKey(name: 'contract_type_id')
  int? contractTypeId;

  @JsonKey(name: 'contract_condition_id')
  int? contractConditionId;

  @JsonKey(name: 'display_name')
  String? displayName;

  Tariff(
      this.id,
      this.name,
      this.max,
      this.min,
      this.isPercent,
      this.price,
      this.contractType,
      this.contractTypeId,
      this.contractConditionId,
      this.displayName);

  factory Tariff.fromJson(Map<String, dynamic> json) => _$TariffFromJson(json);
  Map<String, dynamic> toJson() => _$TariffToJson(this);
}