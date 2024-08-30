// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pageable _$PageableFromJson(Map<String, dynamic> json) => Pageable(
      (json['totalPages'] as num).toInt(),
      (json['totalElements'] as num).toInt(),
      (json['size'] as num).toInt(),
      json['content'] as List<dynamic>,
    );

Map<String, dynamic> _$PageableToJson(Pageable instance) => <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'size': instance.size,
      'content': instance.content,
    };
