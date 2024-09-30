import 'package:json_annotation/json_annotation.dart';

part 'contract_type.g.dart';

@JsonSerializable()
class ContractType{
  int id;
  String? name;

  @JsonKey(name: 'document_number_prefix')
  String? documentNumberPrefix;

  @JsonKey(name: 'service_max')
  int? serviceMax;
  String? description;
  bool? billing;

  ContractType(this.id, this.name, this.documentNumberPrefix, this.serviceMax,
      this.description, this.billing);

  factory ContractType.fromJson(Map<String, dynamic> json) => _$ContractTypeFromJson(json);
  Map<String, dynamic> toJson() => _$ContractTypeToJson(this);
}