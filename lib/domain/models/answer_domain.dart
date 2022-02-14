import 'package:json_annotation/json_annotation.dart';

part 'answer_domain.g.dart';

@JsonSerializable()
class AnswerDomain {
  AnswerDomain(this.answer, this.isCorrect);

  Map<String, dynamic> toJson() => _$AnswerDomainToJson(this);

  final String answer;
  @JsonKey(name: 'is_correct')
  final bool isCorrect;
}
