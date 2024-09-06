import 'package:json_annotation/json_annotation.dart';

class Attachment{
  int id;
  String name;

  @JsonKey(name: 'original_name')
  String originalName;

  @JsonKey(name: 'content_type')
  String contentType;

  String path;
  String url;

  Attachment(this.id, this.name, this.originalName, this.contentType,
      this.path, this.url);

}