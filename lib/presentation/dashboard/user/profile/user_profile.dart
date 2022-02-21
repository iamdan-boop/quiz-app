import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quiz_app/injection_container.dart';
import 'package:quiz_app/presentation/dashboard/user/profile/bloc/user_cubit.dart';
import 'package:quiz_app/presentation/dashboard/user/profile/bloc/user_profile_state.dart';
import 'package:formz/formz.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => getIt<UserCubit>()..getCurrentQuizzes(),
          child: BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              if (state.submissionStatus.isSubmissionSuccess) {
                _refreshController.refreshCompleted();
              }
            },
            builder: (context, state) {
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: () => context.read<UserCubit>().getCurrentQuizzes(),
                header: const WaterDropHeader(),
                enablePullDown: true,
                child: Column(
                  children: [
                    Card(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text('Name: Dan Janus Pineda'),
                            Text('Answered Quiz: ${state.quizzes.length}'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Accomplished Quizzes',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    state.submissionStatus.isSubmissionInProgress
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : state.quizzes.isEmpty
                            ? const Center(child: Text('No Current Quizzes'))
                            : ListView.builder(
                                itemCount: state.quizzes.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final quiz = state.quizzes[index];
                                  return GestureDetector(
                                    child: Card(
                                      color: Color(
                                          math.Random().nextInt(0xffffffff)),
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Points: ${quiz.points}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  'Questions: ${quiz.questions!.length}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
