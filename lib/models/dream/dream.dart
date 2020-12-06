import 'package:dreamer/models/dream/element.dart';
import 'package:dreamer/models/dream/feeling.dart';
import 'package:dreamer/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'dream.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class Dream {
  final DateTime created;
  final DateTime modified;
  final String identifier;
  final User user;
  final String publicationStatus;
  final String dreamClearance;
  final String text;
  final String title;
  final DateTime dreamDate;
  final List<Element> elements;
  final List<Feeling> feelings;

  Dream(this.created,
      this.modified,
      this.identifier,
      this.user,
      this.publicationStatus,
      this.dreamClearance,
      this.text,
      this.title,
      this.dreamDate,
      this.elements,
      this.feelings);


  factory Dream.fromJson(Map<String, dynamic> json) => _$DreamFromJson(json);

  Map<String, dynamic> toJson() => _$DreamToJson(this);

  String get createdFormatted {
    return timeago.format(created, locale: 'en_short');
  }
}
