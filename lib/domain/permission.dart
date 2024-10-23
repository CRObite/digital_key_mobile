
import 'package:json_annotation/json_annotation.dart';

part 'permission.g.dart';

@JsonSerializable()
class Permission{
  String? name;

  @JsonKey(name: 'can_create')
  bool? canCreate;

  @JsonKey(name: 'can_read')
  bool? canRead;

  @JsonKey(name: 'can_update')
  bool? canUpdate;

  @JsonKey(name: 'can_delete')
  bool? canDelete;

  Permission(
      this.name, this.canCreate, this.canRead, this.canUpdate, this.canDelete);

  factory Permission.fromJson(Map<String, dynamic> json) => _$PermissionFromJson(json);
  Map<String, dynamic> toJson() => _$PermissionToJson(this);
}