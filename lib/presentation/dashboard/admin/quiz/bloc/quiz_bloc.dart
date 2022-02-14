import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/infrastructure/api.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/quiz_event.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({
    required QuizApi quizApi,
  })  : _quizApi = quizApi,
        super(const QuizState()) {
    on<GetQuizzes>(_getQuizzes);
    on<DeleteQuiz>(_deleteQuiz);
  }

  Future<void> _getQuizzes(
    GetQuizzes event,
    Emitter<QuizState> emit,
  ) async {
    emit(state.copyWith(submissionStatus: FormzStatus.submissionInProgress));
    try {
      final quizzes = await _quizApi.getQuizzes();
      return emit(state.copyWith( 
        quizzes: quizzes,
        submissionStatus: FormzStatus.submissionSuccess,
      ));
    } catch (e) {
      return emit(state.copyWith(
        submissionStatus: FormzStatus.submissionFailure,
      ));
    }
  }

  Future<void> _deleteQuiz(
    DeleteQuiz event,
    Emitter<QuizState> emit,
  ) async {
    emit(state.copyWith(submissionStatus: FormzStatus.submissionInProgress));
    try {
      await _quizApi.deleteQuiz(quizId: event.quizId);
      final quizzes = await _quizApi.getQuizzes();
      return emit(state.copyWith(
        quizzes: quizzes,
        submissionStatus: FormzStatus.submissionSuccess,
      ));
    } catch (_) {
      return emit(state.copyWith(
        submissionStatus: FormzStatus.submissionFailure,
      ));
    }
  }

  final QuizApi _quizApi;
}
