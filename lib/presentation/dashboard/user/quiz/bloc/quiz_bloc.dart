import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/infrastructure/api.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/bloc/quiz_event.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/bloc/quiz_state.dart';

class QuizUserBloc extends Bloc<QuizUserEvent, QuizUserState> {
  QuizUserBloc({
    required QuizApi quizApi,
  })  : _quizApi = quizApi,
        super(const QuizUserState()) {
    on<GetQuizzes>(_getUserQuizzes);
  }

  Future<void> _getUserQuizzes(
    GetQuizzes event,
    Emitter<QuizUserState> emit,
  ) async {
    emit(state.copyWith(submissionStatus: FormzStatus.submissionInProgress));
    try {
      final quizzes = await _quizApi.getUserQuizzes();
      return emit(state.copyWith(
        submissionStatus: FormzStatus.submissionSuccess,
        quizzes: quizzes,
      ));
    } catch (_) {
      return emit(state.copyWith(
        submissionStatus: FormzStatus.submissionFailure,
      ));
    }
  }

  final QuizApi _quizApi;
}
