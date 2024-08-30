// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expiration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expiration _$ExpirationFromJson(Map<String, dynamic> json) => Expiration(
      json['expires_at'] as String?,
      (json['days_left'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExpirationToJson(Expiration instance) =>
    <String, dynamic>{
      'expires_at': instance.expiresAt,
      'days_left': instance.daysLeft,
    };
