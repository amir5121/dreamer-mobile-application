import 'package:json_annotation/json_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'dreamer_notification.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DreamerNotification {
  final DateTime created;
  final DateTime modified;
  final String identifier;
  final String text;
  final String title;
  final String image;

  DreamerNotification(
      this.created, this.modified, this.identifier, this.text, this.title, this.image);

  factory DreamerNotification.fromJson(Map<String, dynamic> json) =>
      _$DreamerNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$DreamerNotificationToJson(this);

  String get createdFormatted {
    return timeago.format(created, locale: 'en_short');
  }
}
