import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class AnswerQuizState extends Equatable {
  const AnswerQuizState({
    this.questionAnswers = const <QuestionAnswer>[],
    this.submissionStatus = FormzStatus.pure,
    this.quizId = 0,
    this.maxIndexSize = 0,
    this.currentIndexQuestion = 0,
    this.pointsEarned = 0,
  });

  AnswerQuizState copyWith({
    List<QuestionAnswer>? questionAnswers,
    FormzStatus? submissionStatus,
    int? quizId,
    int? maxIndexSize,
    int? pointsEarned,
    int? currentIndexQuestion,
  }) {
    return AnswerQuizState(
      pointsEarned: pointsEarned ?? this.pointsEarned,
      maxIndexSize: maxIndexSize ?? this.maxIndexSize,
      currentIndexQuestion: currentIndexQuestion ?? this.currentIndexQuestion,
      questionAnswers: questionAnswers ?? this.questionAnswers,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      quizId: quizId ?? this.quizId,
    );
  }

  final List<QuestionAnswer> questionAnswers;
  final FormzStatus submissionStatus;
  final int quizId;
  final int currentIndexQuestion;
  final int maxIndexSize;
  final int pointsEarned;

  @override
  List<Object?> get props => [
        questionAnswers,
        submissionStatus,
        quizId,
        maxIndexSize,
        currentIndexQuestion,
        pointsEarned,
      ];
}

class QuestionAnswer extends Equatable {
  const QuestionAnswer({
    required this.questionId,
    required this.answerId,
  });

  QuestionAnswer copyWith({
    int? questionId,
    int? answerId,
  }) {
    return QuestionAnswer(
      questionId: questionId ?? this.questionId,
      answerId: answerId ?? this.answerId,
    );
  }

  final int questionId;
  final int answerId;

  @override
  List<Object?> get props => [questionId, answerId];
}
