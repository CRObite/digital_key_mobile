import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/attachment.dart';
import 'package:web_com/domain/client_contract_service.dart';

part 'client_contract_service_group.g.dart';

@JsonSerializable()
class ClientContractServiceGroup{
  int? id;
  String? name;
  Attachment? logo;
  List<ClientContractService>? content;

  ClientContractServiceGroup(this.id, this.name, this.logo, this.content);

  factory ClientContractServiceGroup.fromJson(Map<String, dynamic> json) => _$ClientContractServiceGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ClientContractServiceGroupToJson(this);
}