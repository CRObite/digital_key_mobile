

import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/domain/permission.dart';

part 'pageable.g.dart';

@JsonSerializable()
class Pageable{
  int totalPages;
  int totalElements;
  int size;
  List<dynamic> content;
  List<Permission>? permissions;

  Pageable(this.totalPages, this.totalElements, this.size, this.content, this.permissions);

  factory Pageable.fromJson(Map<String, dynamic> json) => _$PageableFromJson(json);
  Map<String, dynamic> toJson() => _$PageableToJson(this);
}