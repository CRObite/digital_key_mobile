// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorDetails _$ErrorDetailsFromJson(Map<String, dynamic> json) => ErrorDetails(
      (json['id'] as num).toInt(),
      json['title'] as String?,
      json['qualifier'] as String?,
      json['details'] as String?,
      (json['operation_error_id'] as num?)?.toInt(),
      json['display_name'] as String?,
    );

Map<String, dynamic> _$ErrorDetailsToJson(ErrorDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'qualifier': instance.qualifier,
      'details': instance.details,
      'operation_error_id': instance.operationErrorId,
      'display_name': instance.displayName,
    };
