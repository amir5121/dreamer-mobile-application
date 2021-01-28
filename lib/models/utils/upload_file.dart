import 'package:dio/dio.dart';

class UploadFile {
  final MultipartFile file;

  UploadFile(this.file);

  // factory UploadFile.fromJson(Map<String, dynamic> json) => UploadFile(
  //       json['file'] as String,
  //     );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'file': this.file,
      };
}
