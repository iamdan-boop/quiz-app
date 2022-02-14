import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_app/infrastructure/models/answer.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  Question({
    required this.id,
    required this.question,
    this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  final int id;
  final String question;
  final List<Answer>? answers;
}
