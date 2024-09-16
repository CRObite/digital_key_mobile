// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['prefix_full'] as String?,
      json['prefix_short'] as String?,
      json['bin_iin'] as String?,
      statusFromJson(json['status'] as String?),
      closingFormFromJson(json['closing_form'] as String?),
      clientConditionFromJson(json['condition'] as String?),
      salesStateFromJson(json['sales_state'] as String?),
      formatFromJson(json['format'] as String?),
      organizationTypeFromJson(json['organization_type'] as String?),
      (json['company_id'] as num?)?.toInt(),
      json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
      json['uuid'] as String?,
      clientTypeFromJson(json['type'] as String?),
      json['partner'] as bool?,
      json['expiration'] == null
          ? null
          : Expiration.fromJson(json['expiration'] as Map<String, dynamic>),
      (json['contacts'] as List<dynamic>?)
          ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['signer'] == null
          ? null
          : Signer.fromJson(json['signer'] as Map<String, dynamic>),
      (json['signer_id'] as num?)?.toInt(),
      (json['addresses'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['state_registration_certificate'] == null
          ? null
          : Attachment.fromJson(
              json['state_registration_certificate'] as Map<String, dynamic>),
      json['vat_certificate'] == null
          ? null
          : Attachment.fromJson(
              json['vat_certificate'] as Map<String, dynamic>),
      json['requisites'] == null
          ? null
          : Attachment.fromJson(json['requisites'] as Map<String, dynamic>),
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['bank_accounts'] as List<dynamic>?)
          ?.map((e) => BankAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['account_manager'] == null
          ? null
          : User.fromJson(json['account_manager'] as Map<String, dynamic>),
      (json['account_manager_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'prefix_full': instance.prefixFull,
      'prefix_short': instance.prefixShort,
      'bin_iin': instance.binIin,
      'status': statusToJson(instance.status),
      'closing_form': closingFormToJson(instance.closingForm),
      'condition': clientConditionToJson(instance.condition),
      'sales_state': salesStateToJson(instance.salesState),
      'format': formatToJson(instance.format),
      'organization_type': organizationTypeToJson(instance.organizationType),
      'company_id': instance.companyId,
      'company': instance.company,
      'uuid': instance.uuid,
      'type': clientTypeToJson(instance.type),
      'partner': instance.partner,
      'expiration': instance.expiration,
      'contacts': instance.contacts,
      'signer': instance.signer,
      'signer_id': instance.signerId,
      'addresses': instance.addresses,
      'state_registration_certificate': instance.stateRegistrationCertificate,
      'vat_certificate': instance.vatCertificate,
      'requisites': instance.requisites,
      'attachments': instance.attachments,
      'bank_accounts': instance.bankAccounts,
      'account_manager': instance.accountManager,
      'account_manager_id': instance.accountManagerId,
    };
