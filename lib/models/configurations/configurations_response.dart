import 'package:json_annotation/json_annotation.dart';

import 'configurations.dart';

part 'configurations_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ConfigurationsResponse {
  final String messageCode;
  final String? message;
  final int code;
  final Configurations data;

  ConfigurationsResponse(this.messageCode, this.message, this.code, this.data);

  factory ConfigurationsResponse.fromJson(Map<String, dynamic> json) {
    return _$ConfigurationsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConfigurationsResponseToJson(this);
}
