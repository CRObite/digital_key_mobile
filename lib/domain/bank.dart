import 'package:json_annotation/json_annotation.dart';

import 'attachment.dart';

class Bank{
  int id;
  String name;
  String bik;


  @JsonKey(name: 'bank_code')
  String bankCode;

  Attachment logo;

  @JsonKey(name: 'logo_id')
  int logoId;

  Bank(this.id, this.name, this.bik, this.bankCode, this.logo, this.logoId);
}