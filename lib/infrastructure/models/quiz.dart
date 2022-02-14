import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_app/infrastructure/models/question.dart';

part 'quiz.g.dart';

@JsonSerializable()
class Quiz {
  Quiz({
    required this.id,
    required this.quizName,
    required this.quizDescription,
    this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

  final int id;
  @JsonKey(name: 'quiz_name')
  final String quizName;
  @JsonKey(name: 'quiz_description')
  final String quizDescription;
  List<Question>? questions;
}
