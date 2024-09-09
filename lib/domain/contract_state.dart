import 'package:json_annotation/json_annotation.dart';

import '../config/client_enum.dart';


part 'contract_state.g.dart';

@JsonSerializable()
class ContractState{
  int? id;
  String? name;
  ClientStatus? type;

  @JsonKey(name: 'created_date')
  String? createdDate;

  @JsonKey(name: 'display_name')
  String? displayName;

  ContractState(
      this.id, this.name, this.type, this.createdDate, this.displayName);

  factory ContractState.fromJson(Map<String, dynamic> json) => _$ContractStateFromJson(json);
  Map<String, dynamic> toJson() => _$ContractStateToJson(this);
}