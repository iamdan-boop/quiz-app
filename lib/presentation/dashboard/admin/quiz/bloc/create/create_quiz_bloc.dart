import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/domain/inputs/generic_string_input.dart';
import 'package:quiz_app/infrastructure/api.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/create/create_quiz_event.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/create/create_quiz_state.dart';

class CreateQuizBloc extends Bloc<CreateQuizEvent, CreateQuizState> {
  CreateQuizBloc({
    required QuizApi quizApi,
  })  : _quizApi = quizApi,
        super(const CreateQuizState()) {
    on<QuizNameChanged>(
      (event, emit) => emit(
        state.copyWith(
          quizName: GenericStringInput.dirty(event.quizName),
        ),
      ),
    );
    on<QuizDescriptionChanged>(
      (event, emit) => emit(
        state.copyWith(
          quizDescription: GenericStringInput.dirty(event.description),
        ),
      ),
    );
    on<QuizDescSubmitted>(_submitQuizDesc);
    on<QuizSubmitted>(_quizSubmitted);
  }

  Future<void> _submitQuizDesc(
    QuizDescSubmitted event,
    Emitter<CreateQuizState> emit,
  ) async {
    final validate = Formz.validate([
      state.quizName,
      state.quizDescription,
    ]);

    if (!validate.isValidated) {
      return emit(state.copyWith(
        submissionStatus: FormzStatus.invalid,
      ));
    }

    emit(state.copyWith(
      submissionStatus: FormzStatus.submissionSuccess,
    ));

    return emit(state.copyWith(
      submissionStatus: FormzStatus.pure,
    ));
  }

  Future<void> _quizSubmitted(
    QuizSubmitted event,
    Emitter<CreateQuizState> emit,
  ) async {
    emit(state.copyWith(submissionStatus: FormzStatus.submissionInProgress));
    if (event.questions.length == 1 && event.questions[0].question.isEmpty) {
      return emit(state.copyWith(submissionStatus: FormzStatus.invalid));
    }

    try {
      await _quizApi.createQuiz(
        quizName: state.quizName.value,
        quizDescription: state.quizDescription.value,
        questions: event.questions,
      );

      return emit(state.copyWith(
        submissionStatus: FormzStatus.submissionSuccess,
      ));
    } on DioError {
      return emit(state.copyWith(
        submissionStatus: FormzStatus.submissionFailure,
      ));
    }
  }

  final QuizApi _quizApi;
}
