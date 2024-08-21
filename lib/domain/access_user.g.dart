// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessUser _$AccessUserFromJson(Map<String, dynamic> json) => AccessUser(
      json['access_token'] as String,
      json['refresh_token'] as String,
      User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccessUserToJson(AccessUser instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'user': instance.user,
    };
