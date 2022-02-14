import 'package:equatable/equatable.dart';
import 'package:quiz_app/domain/models/question_domain.dart';

abstract class CreateQuizEvent extends Equatable {}

class QuizNameChanged extends CreateQuizEvent {
  QuizNameChanged(this.quizName);

  final String quizName;

  @override
  List<Object?> get props => [quizName];
}

class QuizDescriptionChanged extends CreateQuizEvent {
  QuizDescriptionChanged(this.description);

  final String description;

  @override
  List<Object?> get props => [description];
}

class QuizSubmitted extends CreateQuizEvent {
  QuizSubmitted(this.questions);

  final List<QuestionDomain> questions;

  @override
  List<Object?> get props => [questions];
}

class QuizDescSubmitted extends CreateQuizEvent {
  @override
  List<Object?> get props => [];
}
