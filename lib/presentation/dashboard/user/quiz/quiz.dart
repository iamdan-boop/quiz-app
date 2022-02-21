import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quiz_app/injection_container.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/answer_quiz.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/bloc/quiz_bloc.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/bloc/quiz_event.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/bloc/quiz_state.dart';

class UserQuizScreen extends StatefulWidget {
  const UserQuizScreen({Key? key}) : super(key: key);

  @override
  State<UserQuizScreen> createState() => _UserQuizScreenState();
}

class _UserQuizScreenState extends State<UserQuizScreen> {
  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<QuizUserBloc>()..add(GetQuizzes()),
      child: BlocConsumer<QuizUserBloc, QuizUserState>(
        listener: (context, state) {
          if (state.submissionStatus.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  const SnackBar(content: Text('Something went wrong')));
          }

          if (state.submissionStatus.isSubmissionSuccess) {
            _refreshController.refreshCompleted();
          }
        },
        builder: (context, state) {
          if (state.submissionStatus.isSubmissionFailure) {
            return const Center(
              child: Text("Could'nt get the quizzes"),
            );
          }

          return SmartRefresher(
            controller: _refreshController,
            onRefresh: () => context.read<QuizUserBloc>().add(GetQuizzes()),
            header: const WaterDropHeader(),
            enablePullDown: true,
            child: ListView.builder(
              itemCount: state.quizzes.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final quiz = state.quizzes[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnswerQuizScreen(
                        quiz: quiz,
                      ),
                    ),
                  ),
                  child: Card(
                    color: Color(math.Random().nextInt(0xffffffff)),
                    margin: const EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.ce,
                        children: [
                          Text(
                            quiz.quizName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            quiz.quizDescription,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'Questions: ${quiz.questions!.length}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
