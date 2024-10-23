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
      (json['permissions'] as List<dynamic>?)
          ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PageableToJson(Pageable instance) => <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'size': instance.size,
      'content': instance.content,
      'permissions': instance.permissions,
    };
