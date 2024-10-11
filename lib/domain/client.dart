import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/config/client_condition_enum.dart';
import 'package:web_com/config/client_type_enum.dart';
import 'package:web_com/config/closing_form_enum.dart';
import 'package:web_com/domain/bank_account.dart';
import 'package:web_com/domain/company.dart';
import 'package:web_com/domain/signer.dart';
import 'package:web_com/domain/user.dart';

import '../config/client_enum.dart';
import '../config/format_enum.dart';
import '../config/organization_type_enum.dart';
import '../config/sales_state_enum.dart';
import 'address.dart';
import 'attachment.dart';
import 'contact.dart';
import 'expiration.dart';

part 'client.g.dart';

@JsonSerializable()
class Client{
  int? id;
  String? name;

  @JsonKey(name: 'prefix_full')
  String? prefixFull;

  @JsonKey(name: 'prefix_short')
  String? prefixShort;

  @JsonKey(name: 'bin_iin')
  String? binIin;

  @JsonKey(fromJson: statusFromJson, toJson: statusToJson)
  ClientStatus? status;

  @JsonKey(name: 'closing_form', fromJson: closingFormFromJson, toJson: closingFormToJson)
  ClosingForm? closingForm;

  @JsonKey( fromJson: clientConditionFromJson, toJson: clientConditionToJson)
  ClientCondition? condition;

  @JsonKey(name: 'sales_state', fromJson: salesStateFromJson, toJson: salesStateToJson)
  SalesState? salesState;

  @JsonKey(fromJson: formatFromJson, toJson: formatToJson)
  Format? format;


  @JsonKey(name: 'organization_type',fromJson: organizationTypeFromJson, toJson: organizationTypeToJson)
  OrganizationType? organizationType;

  @JsonKey(name: 'company_id')
  int? companyId;

  Company? company;


  String? uuid;

  @JsonKey( fromJson: clientTypeFromJson, toJson: clientTypeToJson)
  ClientType? type;

  bool? partner;
  Expiration? expiration;
  List<Contact>? contacts;
  Signer? signer;

  @JsonKey(name: 'signer_id')
  int? signerId;

  List<Address>? addresses;

  @JsonKey(name: 'state_registration_certificate')
  Attachment? stateRegistrationCertificate;

  @JsonKey(name: 'vat_certificate')
  Attachment? vatCertificate;

  Attachment? requisites;

  Attachment? order;

  List<Attachment>? attachments;

  @JsonKey(name: 'bank_accounts')
  List<BankAccount>? bankAccounts;

  @JsonKey(name: 'account_manager')
  User? accountManager;

  @JsonKey(name: 'account_manager_id')
  int? accountManagerId;

  User? owner;

  @JsonKey(name: 'owner_id')
  int? ownerId;


  Client(
      this.id,
      this.name,
      this.prefixFull,
      this.prefixShort,
      this.binIin,
      this.status,
      this.closingForm,
      this.condition,
      this.salesState,
      this.format,
      this.organizationType,
      this.companyId,
      this.company,
      this.uuid,
      this.type,
      this.partner,
      this.expiration,
      this.contacts,
      this.signer,
      this.signerId,
      this.addresses,
      this.stateRegistrationCertificate,
      this.vatCertificate,
      this.requisites,
      this.order,
      this.attachments,
      this.bankAccounts,
      this.accountManager,
      this.accountManagerId,
      this.owner,
      this.ownerId);

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

