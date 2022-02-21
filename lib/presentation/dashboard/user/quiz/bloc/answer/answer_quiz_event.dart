import 'package:equatable/equatable.dart';

abstract class AnswerQuizEvent extends Equatable {}

class AnswerSelectedQuiz extends AnswerQuizEvent {
  AnswerSelectedQuiz({
    required this.questionId,
    required this.answerId,
  });

  final int questionId;
  final int answerId;

  @override
  List<Object?> get props => [
        questionId,
        answerId,
      ];
}

class SetNextIndex extends AnswerQuizEvent {
  @override
  List<Object?> get props => [];
}

class SetQuizId extends AnswerQuizEvent {
  SetQuizId({
    required this.id,
  });
  final int id;

  @override
  List<Object?> get props => [id];
}

class SetMaxIndex extends AnswerQuizEvent {
  SetMaxIndex({
    required this.maxIndexSize,
  });

  final int maxIndexSize;

  @override
  List<Object?> get props => [maxIndexSize];
}

class SubmitAnswerQuiz extends AnswerQuizEvent {
  @override
  List<Object?> get props => [];
}
