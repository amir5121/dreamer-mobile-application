import 'package:dreamer/models/dream/dream_element.dart';
import 'package:dreamer/models/dream/feeling.dart';
import 'package:dreamer/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'dream.g.dart';

@JsonSerializable(nullable: true, fieldRename: FieldRename.snake)
class Dream {
  String text;
  String title;
  DateTime created;
  DateTime modified;
  String identifier;
  User user;
  String publicationStatus;
  int dreamClearance;
  String dreamClearanceDisplay;
  DateTime dreamDate;
  List<DreamElement> elements;
  List<Feeling> feelings;
  String voice;
  double voiceDuration;
  List<double> voiceWave;

  Dream(
      {this.created,
      this.modified,
      this.identifier,
      this.user,
      this.publicationStatus,
      this.dreamClearance,
      this.text,
      this.title,
      this.dreamDate,
      this.dreamClearanceDisplay,
      this.voice,
      this.elements,
      this.voiceWave,
      this.voiceDuration,
      this.feelings});

  factory Dream.fromJson(Map<String, dynamic> json) => _$DreamFromJson(json);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonResult = _$DreamToJson(this);
    if (this.voice != null && this.voice.contains('http')) {
      jsonResult.remove('voice');
    }
    return jsonResult;
  }

  String get createdFormatted {
    return timeago.format(created, locale: 'en');
  }
}
