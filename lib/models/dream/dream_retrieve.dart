import 'package:json_annotation/json_annotation.dart';

import 'dream.dart';

part 'dream_retrieve.g.dart';

@JsonSerializable()
class DreamRetrieve {
  final String messageCode;
  final String? message;
  final int code;
  final Dream data;

  DreamRetrieve(this.messageCode, this.message, this.code, this.data);

  factory DreamRetrieve.fromJson(Map<String, dynamic> json) =>
      _$DreamRetrieveFromJson(json);

  Map<String, dynamic> toJson() => _$DreamRetrieveToJson(this);
}
