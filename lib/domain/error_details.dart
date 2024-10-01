import 'package:json_annotation/json_annotation.dart';

part 'error_details.g.dart';

@JsonSerializable()
class ErrorDetails{
  int id;
  String? title;
  String? qualifier;
  String? details;

  @JsonKey(name: 'operation_error_id')
  int? operationErrorId;

  @JsonKey(name: 'display_name')
  String? displayName;

  ErrorDetails(this.id, this.title, this.qualifier, this.details,
      this.operationErrorId, this.displayName);

  factory ErrorDetails.fromJson(Map<String, dynamic> json) => _$ErrorDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorDetailsToJson(this);
}