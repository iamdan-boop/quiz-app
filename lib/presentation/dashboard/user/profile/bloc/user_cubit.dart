import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/infrastructure/api.dart';
import 'package:quiz_app/presentation/dashboard/user/profile/bloc/user_profile_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required QuizApi quizApi,
  })  : _quizApi = quizApi,
        super(const UserState());

  void getCurrentQuizzes() async {
    emit(state.copyWith(submissionStatus: FormzStatus.submissionInProgress));
    try {
      final quizzes = await _quizApi.getCurrentQuizzes();
      return emit(state.copyWith(
        submissionStatus: FormzStatus.submissionSuccess,
        quizzes: quizzes,
      ));
    } catch (e) {
      return emit(state.copyWith(
        submissionStatus: FormzStatus.submissionFailure,
      ));
    }
  }

  final QuizApi _quizApi;
}
