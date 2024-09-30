import 'package:json_annotation/json_annotation.dart';

part 'service_category.g.dart';

@JsonSerializable()
class ServiceCategory{
  int id;
  String? name;

  @JsonKey(name: 'display_name')
  String? displayName;

  ServiceCategory(this.id, this.name, this.displayName);

  factory ServiceCategory.fromJson(Map<String, dynamic> json) => _$ServiceCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceCategoryToJson(this);
}