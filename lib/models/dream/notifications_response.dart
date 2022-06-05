import 'package:dreamer/models/dream/notification_pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notifications_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  final String messageCode;
  final String? message;
  final int code;
  final NotificationPagination data;

  NotificationResponse(this.messageCode, this.message, this.code, this.data);

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}
