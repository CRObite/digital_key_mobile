// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      (json['id'] as num?)?.toInt(),
      json['full_name'] as String?,
      json['phone'] as String?,
      json['email'] as String?,
      json['contact_person'] as bool?,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'phone': instance.phone,
      'email': instance.email,
      'contact_person': instance.contactPerson,
    };
