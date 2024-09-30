// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      (json['id'] as num).toInt(),
      json['name'] as String?,
      providerTypeFromJson(json['provider_type'] as String?),
      json['logo'] == null
          ? null
          : Attachment.fromJson(json['logo'] as Map<String, dynamic>),
      (json['logo_id'] as num?)?.toInt(),
      json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      (json['currency_id'] as num?)?.toInt(),
      json['category'] == null
          ? null
          : ServiceCategory.fromJson(json['category'] as Map<String, dynamic>),
      (json['category_id'] as num?)?.toInt(),
      json['display_name'] as String?,
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'provider_type': providerTypeToJson(instance.providerType),
      'logo': instance.logo,
      'logo_id': instance.logoId,
      'currency': instance.currency,
      'currency_id': instance.currencyId,
      'category': instance.category,
      'category_id': instance.categoryId,
      'display_name': instance.displayName,
    };
