

import 'package:json_annotation/json_annotation.dart';

part 'pageable.g.dart';

@JsonSerializable()
class Pageable{
  int totalPages;
  int totalElements;
  int size;
  List<dynamic> content;

  Pageable(this.totalPages, this.totalElements, this.size, this.content);

  factory Pageable.fromJson(Map<String, dynamic> json) => _$PageableFromJson(json);
  Map<String, dynamic> toJson() => _$PageableToJson(this);
}