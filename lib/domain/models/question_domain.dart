import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_app/domain/models/answer_domain.dart';

part 'question_domain.g.dart';

@JsonSerializable()
class QuestionDomain {
  QuestionDomain({
    required this.question,
    required this.answers,
  });

  Map<String, dynamic> toJson() => _$QuestionDomainToJson(this);

  @JsonKey(name: 'question')
  final String question;
  @JsonKey(name: 'answers')
  final List<AnswerDomain> answers;
}
