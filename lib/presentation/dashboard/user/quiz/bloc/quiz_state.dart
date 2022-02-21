import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/infrastructure/models/quiz.dart';

class QuizUserState extends Equatable {
  const QuizUserState({
    this.quizzes = const <Quiz>[],
    this.submissionStatus = FormzStatus.pure,
    this.currentQuiz = 0,
    this.questionAnswers = const <QuestionAnswer>[],
  });

  final List<Quiz> quizzes;
  final FormzStatus submissionStatus;
  final int currentQuiz;
  final List<QuestionAnswer> questionAnswers;

  QuizUserState copyWith({
    List<Quiz>? quizzes,
    FormzStatus? submissionStatus,
    int? currentQuiz,
    List<QuestionAnswer>? questionAnswers,
  }) {
    return QuizUserState(
      currentQuiz: currentQuiz ?? this.currentQuiz,
      quizzes: quizzes ?? this.quizzes,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      questionAnswers: questionAnswers ?? this.questionAnswers,
    );
  }

  @override
  List<Object?> get props => [
        quizzes,
        submissionStatus,
        currentQuiz,
        questionAnswers,
      ];
}

class QuestionAnswer extends Equatable {
  const QuestionAnswer({
    required this.questionId,
    required this.answerId,
  });

  final int questionId;
  final int answerId;

  @override
  List<Object?> get props => [questionId, answerId];
}
