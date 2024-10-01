import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/service.dart';

part 'nomenclature.g.dart';

@JsonSerializable()
class Nomenclature{
  int id;
  String? name;
  String? code;

  @JsonKey(name: 'is_budget')
  bool? isBudget;

  @JsonKey(name: 'is_fee')
  bool? isFee;

  @JsonKey(name: 'auto_computable')
  bool? autoComputable;
  Service? service;

  @JsonKey(name: 'service_id')
  int? serviceId;

  @JsonKey(name: 'display_name')
  String? displayName;

  Nomenclature(this.id, this.name, this.code, this.isBudget, this.isFee,
      this.autoComputable, this.service, this.serviceId, this.displayName);

  factory Nomenclature.fromJson(Map<String, dynamic> json) => _$NomenclatureFromJson(json);
  Map<String, dynamic> toJson() => _$NomenclatureToJson(this);

}