import 'package:dio/dio.dart';

class UploadFile {
  final String file;

  UploadFile(this.file);

  // factory UploadFile.fromJson(Map<String, dynamic> json) => UploadFile(
  //       json['file'] as String,
  //     );

  Future<Map<String, dynamic>> toJson() async => <String, dynamic>{
        'file': await MultipartFile.fromFile(this.file),
      };
}
