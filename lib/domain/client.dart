import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/config/closing_form_enum.dart';

import '../config/client_enum.dart';
import 'contact.dart';
import 'expiration.dart';

part 'client.g.dart';

@JsonSerializable()
class Client{
  int? id;
  String? name;

  @JsonKey(name: 'bin_iin')
  String? binIin;

  @JsonKey(fromJson: statusFromJson, toJson: statusToJson)
  ClientStatus? status;


  @JsonKey(name: 'closing_form', fromJson: closingFormFromJson, toJson: closingFormToJson)
  ClosingForm? closingForm;

  String? uuid;
  String? type;
  bool? partner;
  Expiration? expiration;
  List<Contact>? contacts;


  Client(this.id, this.name, this.binIin, this.status, this.closingForm,
      this.uuid, this.type, this.partner, this.expiration, this.contacts);

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

