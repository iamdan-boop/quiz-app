import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/infrastructure/models/quiz.dart';
import 'package:quiz_app/injection_container.dart';
import 'package:quiz_app/presentation/dashboard/user/profile/user_profile.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/bloc/answer/answer_quiz_bloc.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/bloc/answer/answer_quiz_event.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/bloc/answer/answer_quiz_state.dart';
import 'package:quiz_app/presentation/dashboard/user/quiz/components/option.dart';
import 'package:quiz_app/presentation/widgets/custom_button.dart';
import 'package:formz/formz.dart';

class AnswerQuizScreen extends StatefulWidget {
  const AnswerQuizScreen({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  final Quiz quiz;

  @override
  _AnswerQuizScreenState createState() => _AnswerQuizScreenState();
}

class _AnswerQuizScreenState extends State<AnswerQuizScreen> {
  final pagingController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => getIt<AnswerQuizBloc>()
            ..add(SetQuizId(
              id: widget.quiz.id,
            ))
            ..add(SetMaxIndex(maxIndexSize: widget.quiz.questions!.length)),
          child: BlocConsumer<AnswerQuizBloc, AnswerQuizState>(
            listener: (context, state) {
              print('currentState: ${state.submissionStatus}');
              if (state.submissionStatus.isSubmissionSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfileScreen()),
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Question:',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          widget.quiz.questions![state.currentIndexQuestion]
                              .question,
                          // 'What is asked what the fuck it is what the dog doing?',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    height: MediaQuery.of(context).size.height * 0.78,
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: pagingController,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.quiz.questions!.length,
                            itemBuilder: (context, pagingIndex) {
                              return ListView.builder(
                                itemCount: widget.quiz.questions![pagingIndex]
                                    .answers!.length,
                                itemBuilder: (context, index) {
                                  final answer = widget.quiz
                                      .questions![pagingIndex].answers![index];
                                  return Option(
                                    answer: answer,
                                    questionAnwers: state.questionAnswers,
                                    isSelected: false,
                                    text: answer.answer,
                                    index: index,
                                    press: () =>
                                        context.read<AnswerQuizBloc>().add(
                                              AnswerSelectedQuiz(
                                                questionId: widget.quiz
                                                    .questions![pagingIndex].id,
                                                answerId: answer.id,
                                              ),
                                            ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        state.submissionStatus.isSubmissionInProgress
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextButton(
                                        onPressed: () =>
                                            pagingController.previousPage(
                                          duration:
                                              const Duration(milliseconds: 700),
                                          curve: Curves.easeOut,
                                        ),
                                        child: const Text(
                                          'Previous',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Flexible(
                                    child: Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          if (state.maxIndexSize ==
                                              state.currentIndexQuestion + 1) {
                                            context
                                                .read<AnswerQuizBloc>()
                                                .add(SubmitAnswerQuiz());
                                            return;
                                          }
                                          context
                                              .read<AnswerQuizBloc>()
                                              .add(SetNextIndex());
                                          pagingController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 700),
                                            curve: Curves.easeIn,
                                          );
                                        },
                                        child: Text(
                                          (state.currentIndexQuestion + 1) ==
                                                  state.maxIndexSize
                                              ? 'Submit'
                                              : 'Next',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                        // CustomButton(
                        //   onTap: () {
                        //     if (state.maxIndexSize ==
                        //         state.currentIndexQuestion + 1) {
                        //       context
                        //           .read<AnswerQuizBloc>()
                        //           .add(SubmitAnswerQuiz());
                        //       return;
                        //     }
                        //     context.read<AnswerQuizBloc>().add(SetNextIndex());
                        //     pagingController.nextPage(
                        //       duration: const Duration(milliseconds: 700),
                        //       curve: Curves.easeIn,
                        //     );
                        //   },
                        //   text: (state.currentIndexQuestion + 1) ==
                        //           state.maxIndexSize
                        //       ? 'Submit'
                        //       : 'Next',
                        // ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
