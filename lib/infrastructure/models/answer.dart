import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer {
  Answer({
    required this.id,
    required this.answer,
    required this.isCorrect,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  final int id;
  final String answer;
  @JsonKey(name: 'is_correct')
  final bool isCorrect;
}
