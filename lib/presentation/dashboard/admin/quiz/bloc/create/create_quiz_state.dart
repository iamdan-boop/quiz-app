import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/domain/inputs/generic_string_input.dart';
import 'package:quiz_app/domain/models/question_domain.dart';

class CreateQuizState extends Equatable {
  const CreateQuizState({
    this.submissionStatus = FormzStatus.pure,
    this.quizName = const GenericStringInput.pure(),
    this.quizDescription = const GenericStringInput.pure(),
    this.questions = const <QuestionDomain>[],
  });

  final FormzStatus submissionStatus;
  final GenericStringInput quizName;
  final GenericStringInput quizDescription;
  final List<QuestionDomain> questions;

  CreateQuizState copyWith({
    FormzStatus? submissionStatus,
    GenericStringInput? quizName,
    GenericStringInput? quizDescription,
    List<QuestionDomain>? questions,
  }) {
    return CreateQuizState(
      submissionStatus: submissionStatus ?? this.submissionStatus,
      quizDescription: quizDescription ?? this.quizDescription,
      quizName: quizName ?? this.quizName,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object?> get props => [
        submissionStatus,
        quizName,
        quizDescription,
        questions,
      ];
}
