import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/infrastructure/models/quiz.dart';

class UserState extends Equatable {
  const UserState({
    this.quizzes = const <Quiz>[],
    this.submissionStatus = FormzStatus.pure,
  });

  UserState copyWith({
    List<Quiz>? quizzes,
    FormzStatus? submissionStatus,
  }) {
    return UserState(
      quizzes: quizzes ?? this.quizzes,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  final List<Quiz> quizzes;
  final FormzStatus submissionStatus;

  @override
  List<Object?> get props => [quizzes, submissionStatus];
}
