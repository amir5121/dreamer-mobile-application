import 'package:json_annotation/json_annotation.dart';

part 'analytics.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake)
class Analytics {
  final String mainQuote;
  final String wordCloud;

  Analytics(this.mainQuote, this.wordCloud);


  factory Analytics.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsToJson(this);
}
