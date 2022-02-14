import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {}

class GetQuizzes extends QuizEvent {
  @override
  List<Object?> get props => [];
}

class DeleteQuiz extends QuizEvent {
  DeleteQuiz({
    required this.quizId,
  });

  final int quizId;

  @override
  List<Object?> get props => [quizId];
}
