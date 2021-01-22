import 'package:json_annotation/json_annotation.dart';

part 'upload_file.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class UploadFile {
  final String file;

  UploadFile(this.file);

  factory UploadFile.fromJson(Map<String, dynamic> json) => _$UploadFileFromJson(json);

  Map<String, dynamic> toJson() => _$UploadFileToJson(this);
}
