import 'package:dio/dio.dart';
import 'package:quiz_app/domain/constants.dart';
import 'package:quiz_app/domain/models/question_domain.dart';
import 'package:quiz_app/infrastructure/models/auth_token.dart';
import 'package:quiz_app/infrastructure/models/quiz.dart';
import 'package:quiz_app/infrastructure/models/user.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

@RestApi(baseUrl: baseURL)
abstract class QuizApi {
  factory QuizApi(
    Dio dio, {
    String baseUrl,
  }) = _QuizApi;

  @POST('/login')
  Future<AuthToken> login({
    @Field('email') required String email,
    @Field('password') required String password,
  });

  @POST('/register')
  Future<AuthToken> register({
    @Field('email') required String email,
    @Field('name') required String name,
    @Field('password') required String password,
  });

  @POST('/me')
  Future<AuthToken> me();

  @GET('/quiz')
  Future<List<Quiz>> getQuizzes();

  @POST('/quiz')
  Future<void> createQuiz({
    @Field('quiz_name') required String quizName,
    @Field('quiz_description') required String quizDescription,
    @Field('questions') required List<QuestionDomain> questions,
  });

  @DELETE('/quiz/{quiz}')
  Future<void> deleteQuiz({
    @Path('quiz') required int quizId,
  });

  // User Quiz
  @GET('/user/quiz')
  Future<List<Quiz>> getUserQuizzes();

  @GET('/user/current-quizzes')
  Future<List<Quiz>> getCurrentQuizzes();

  @GET('/leaderboards')
  Future<List<User>> getLeaderboards();

  @POST('/answer-quiz')
  Future<void> submitQuizAnswer({
    @Field('quiz') required int quizId,
    @Field('answers') required List<int> answers,
  });
}
