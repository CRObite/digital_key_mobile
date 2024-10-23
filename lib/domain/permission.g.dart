// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission(
      json['name'] as String?,
      json['can_create'] as bool?,
      json['can_read'] as bool?,
      json['can_update'] as bool?,
      json['can_delete'] as bool?,
    );

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'name': instance.name,
      'can_create': instance.canCreate,
      'can_read': instance.canRead,
      'can_update': instance.canUpdate,
      'can_delete': instance.canDelete,
    };
