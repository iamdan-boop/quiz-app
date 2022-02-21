import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quiz_app/infrastructure/models/quiz.dart';
import 'package:quiz_app/injection_container.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/quiz_bloc.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/quiz_event.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/quiz_state.dart';

import 'dart:math' as math;

class QuizesScreen extends StatefulWidget {
  const QuizesScreen({Key? key}) : super(key: key);

  @override
  State<QuizesScreen> createState() => _QuizesScreenState();
}

class _QuizesScreenState extends State<QuizesScreen> {
  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Quizzes'),
      //   actions: [
      //     IconButton(
      //       onPressed: () => Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const CreateQuizScreen(),
      //         ),
      //       ),
      //       icon: const Icon(Icons.add),
      //     ),
      //   ],
      // ),
      body: BlocProvider(
        create: (context) => getIt<QuizBloc>()..add(GetQuizzes()),
        child: BlocConsumer<QuizBloc, QuizState>(
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
              header: const WaterDropHeader(),
              onRefresh: () => context.read<QuizBloc>().add(GetQuizzes()),
              enablePullDown: true,
              child: ListView.builder(
                itemCount: state.quizzes.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final quiz = state.quizzes[index];
                  return GestureDetector(
                    onLongPress: () => showDeleteDialog(context, quiz, () {
                      context.read<QuizBloc>().add(DeleteQuiz(quizId: quiz.id));

                      Navigator.pop(context);
                    }),
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
      ),
    );
  }

  void showDeleteDialog(
    BuildContext context,
    Quiz quiz,
    Function() onPressed,
  ) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Destructive Action'),
          content: Text(
            'Deleting Quiz ${quiz.quizName} will never be recovered againg.',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: onPressed,
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
