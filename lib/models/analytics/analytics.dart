import 'package:dreamer/models/analytics/feeling_summarize.dart';
import 'package:json_annotation/json_annotation.dart';

import 'clearance_summarize.dart';

part 'analytics.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Analytics {
  final String mainQuote;
  final String wordCloud;
  final List<FeelingSummarize> feelings;
  final List<ClearanceSummarize> clearances;
  final int dreamsCount;

  Analytics(
      this.mainQuote, this.wordCloud, this.feelings, this.dreamsCount, this.clearances);

  factory Analytics.fromJson(Map<String, dynamic> json) => _$AnalyticsFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsToJson(this);
}
