import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/infrastructure/api.dart';
import 'package:quiz_app/presentation/dashboard/admin/leaderboards/cubit/leaderboards_state.dart';

class LeaderboardsCubit extends Cubit<LeaderboardState> {
  LeaderboardsCubit({
    required QuizApi quizApi,
  })  : _quizApi = quizApi,
        super(const LeaderboardState());

  Future<void> getLeaderboards() async {
    emit(state.copyWith(submissionStatus: FormzStatus.submissionInProgress));
    try {
      final leaderboards = await _quizApi.getLeaderboards();
      return emit(state.copyWith(
        submissionStatus: FormzStatus.submissionSuccess,
        leaderboards: leaderboards,
      ));
    } catch (_) {
      return emit(state.copyWith(
        submissionStatus: FormzStatus.submissionFailure,
      ));
    }
  }

  final QuizApi _quizApi;
}
