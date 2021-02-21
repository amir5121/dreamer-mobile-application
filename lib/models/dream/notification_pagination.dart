import 'package:dreamer/models/dream/dreamer_notification.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_pagination.g.dart';

@JsonSerializable()
class NotificationPagination {
  final String next;
  final String previous;
  final List<DreamerNotification> results;

  NotificationPagination(this.next, this.previous, this.results);

  factory NotificationPagination.fromJson(Map<String, dynamic> json) =>
      _$NotificationPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPaginationToJson(this);
}
