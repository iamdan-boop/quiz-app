import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/infrastructure/models/quiz.dart';

class QuizState extends Equatable {
  const QuizState({
    this.quizzes = const <Quiz>[],
    this.submissionStatus = FormzStatus.pure,
  });

  QuizState copyWith({
    List<Quiz>? quizzes,
    FormzStatus? submissionStatus,
  }) {
    return QuizState(
      quizzes: quizzes ?? this.quizzes,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  final List<Quiz> quizzes;
  final FormzStatus submissionStatus;

  @override
  List<Object?> get props => [quizzes, submissionStatus];
}
