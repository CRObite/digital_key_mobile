import 'package:json_annotation/json_annotation.dart';
import 'package:web_com/config/signer_type_enum.dart';
import 'package:web_com/domain/attachment.dart';
import 'package:web_com/domain/position.dart';
import 'package:web_com/domain/signing_base.dart';


part 'signer.g.dart';

@JsonSerializable()
class Signer{
  int? id;
  String? name;

  SignerType? type;

  Position? position;

  @JsonKey(name: 'position_id')
  int? positionId;

  @JsonKey(name: 'stamp_file')
  Attachment? stampFile;

  @JsonKey(name: 'stamp_file_id')
  int? stampFileId;

  @JsonKey(name: 'signing_base')
  SigningBase? signingBase;

  @JsonKey(name: 'signing_base_id')
  int? signingBaseId;

  @JsonKey(name: 'display_name')
  String? displayName;


  Signer(
      this.id,
      this.name,
      this.type,
      this.position,
      this.positionId,
      this.stampFile,
      this.stampFileId,
      this.signingBase,
      this.signingBaseId,
      this.displayName);


  factory Signer.fromJson(Map<String, dynamic> json) => _$SignerFromJson(json);
  Map<String, dynamic> toJson() => _$SignerToJson(this);
}