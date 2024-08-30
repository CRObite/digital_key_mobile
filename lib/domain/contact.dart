import 'package:json_annotation/json_annotation.dart';
part 'contact.g.dart';

@JsonSerializable()
class Contact{
  int? id;

  @JsonKey(name: 'full_name')
  String? fullName;

  String? phone;
  String? email;

  @JsonKey(name: 'contact_person')
  bool? contactPerson;

  Contact(this.id, this.fullName, this.phone, this.email, this.contactPerson);

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}