import 'package:json_annotation/json_annotation.dart';

part 'notification_register.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class NotificationRegister {
  final String registrationId;
  final String type;

  NotificationRegister(this.registrationId, this.type);

  factory NotificationRegister.fromJson(Map<String, dynamic> json) {
    return _$NotificationRegisterFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationRegisterToJson(this);
}
