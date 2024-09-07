// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['original_name'] as String?,
      json['content_type'] as String?,
      json['path'] as String?,
      json['url'] as String?,
    );

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'original_name': instance.originalName,
      'content_type': instance.contentType,
      'path': instance.path,
      'url': instance.url,
    };
