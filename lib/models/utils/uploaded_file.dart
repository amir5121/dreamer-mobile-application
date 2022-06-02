import 'package:json_annotation/json_annotation.dart';

part 'uploaded_file.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UploadedFile {
  final String filePath;

  UploadedFile(this.filePath);

  factory UploadedFile.fromJson(Map<String, dynamic> json) =>
      _$UploadedFileFromJson(json);

  Map<String, dynamic> toJson() => _$UploadedFileToJson(this);
}
