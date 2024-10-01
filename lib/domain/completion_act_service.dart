import 'package:json_annotation/json_annotation.dart';

part 'completion_act_service.g.dart';

@JsonSerializable()
class CompletionActService{
  int id;
  String? name;
  double? price;
  double? quantity;

  @JsonKey(name: 'sum_nominal')
  double? sumNominal;

  @JsonKey(name: 'sum_vat')
  double? sumVat;

  @JsonKey(name: 'completion_act_id')
  int? completionActId;

  @JsonKey(name: 'display_name')
  String? displayName;


  CompletionActService(this.id, this.name, this.price, this.quantity,
      this.sumNominal, this.sumVat, this.completionActId, this.displayName);

  factory CompletionActService.fromJson(Map<String, dynamic> json) => _$CompletionActServiceFromJson(json);
  Map<String, dynamic> toJson() => _$CompletionActServiceToJson(this);
}