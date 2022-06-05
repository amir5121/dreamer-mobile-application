import 'package:dreamer/models/analytics/analytics.dart';
import 'package:json_annotation/json_annotation.dart';

part 'analytics_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AnalyticsResponse {
  final String? messageCode;
  final String? message;
  final int? code;
  final Analytics data;

  AnalyticsResponse(this.messageCode, this.message, this.code, this.data);

  factory AnalyticsResponse.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsResponseToJson(this);
}
