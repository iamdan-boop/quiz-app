import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/infrastructure/api.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/bloc/answer/answer_quiz_event.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/bloc/answer/answer_quiz_state.dart';

class AnswerQuizBloc extends Bloc<AnswerQuizEvent, AnswerQuizState> {
  AnswerQuizBloc({
    required QuizApi quizApi,
  })  : _quizApi = quizApi,
        super(const AnswerQuizState()) {
    on<AnswerSelectedQuiz>(_answerSelectedQuiz);
    on<SetNextIndex>(_setNextIndex);
    on<SetQuizId>((event, emit) => emit(state.copyWith(quizId: event.id)));
    on<SetMaxIndex>((event, emit) =>
        emit(state.copyWith(maxIndexSize: event.maxIndexSize)));
    on<SubmitAnswerQuiz>(_submitAnswerQuiz);
  }

  Future<void> _answerSelectedQuiz(
    AnswerSelectedQuiz event,
    Emitter<AnswerQuizState> emit,
  ) async {
    final exist = state.questionAnswers.any(
      (element) =>
          element.questionId == event.questionId &&
          element.answerId == event.answerId,
    );
    if (exist) return;
    final newAnswerToQuestion = QuestionAnswer(
      answerId: event.answerId,
      questionId: event.questionId,
    );
    return emit(state.copyWith(
      questionAnswers: [...state.questionAnswers]
        ..removeWhere((element) => element.questionId == event.questionId)
        ..add(newAnswerToQuestion),
    ));
  }

  Future<void> _setNextIndex(
    SetNextIndex event,
    Emitter<AnswerQuizState> emit,
  ) async {
    if (state.maxIndexSize == state.currentIndexQuestion) return;
    return emit(state.copyWith(
      currentIndexQuestion: state.currentIndexQuestion + 1,
    ));
  }

  Future<void> _submitAnswerQuiz(
    SubmitAnswerQuiz event,
    Emitter<AnswerQuizState> emit,
  ) async {
    emit(state.copyWith(submissionStatus: FormzStatus.submissionInProgress));
    try {
      final quizPoints = await _quizApi.submitQuizAnswer(
        quizId: state.quizId,
        answers: state.questionAnswers.map((e) => e.answerId).toList(),
      );
      return emit(state.copyWith(
        pointsEarned: 10,
        submissionStatus: FormzStatus.submissionSuccess,
      ));
    } catch (e) {
      print(e);
      return emit(state.copyWith(
        submissionStatus: FormzStatus.submissionFailure,
      ));
    }
  }

  final QuizApi _quizApi;
}
