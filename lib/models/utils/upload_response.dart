import 'package:dreamer/models/utils/uploaded_file.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_response.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class UploadResponse {
  final String messageCode;
  final String message;
  final int code;
  final UploadedFile data;

  UploadResponse(this.messageCode, this.message, this.code, this.data);

  factory UploadResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadResponseToJson(this);
}
