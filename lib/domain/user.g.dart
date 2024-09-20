// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['iin'] as String?,
      json['login'] as String?,
      json['email'] as String?,
      json['avatar'] == null
          ? null
          : Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      (json['avatar_id'] as num?)?.toInt(),
      json['mobile'] as String?,
      json['birth_day'] as String?,
      (json['app_role_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iin': instance.iin,
      'login': instance.login,
      'email': instance.email,
      'avatar': instance.avatar,
      'avatar_id': instance.avatarId,
      'mobile': instance.mobile,
      'birth_day': instance.birthDay,
      'app_role_id': instance.appRoleId,
    };
