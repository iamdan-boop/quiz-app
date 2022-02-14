import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/domain/models/answer_domain.dart';
import 'package:quiz_app/domain/models/question_domain.dart';
import 'package:quiz_app/presentation/dashboard/admin/admin_dashboard.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/create/create_quiz_bloc.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/create/create_quiz_event.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/create/create_quiz_state.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/quizes.dart';
import 'package:quiz_app/presentation/widgets/custom_button.dart';
import 'package:quiz_app/presentation/widgets/custom_form_field.dart';

import 'package:formz/formz.dart';

class CreatePageView extends StatefulWidget {
  const CreatePageView({
    Key? key,
    required this.createQuizBloc,
  }) : super(key: key);

  final CreateQuizBloc createQuizBloc;

  @override
  _CreatePageViewState createState() => _CreatePageViewState();
}

class _CreatePageViewState extends State<CreatePageView> {
  final questionControllers = <QuestionControllers>[]..add(
      QuestionControllers(
        question: TextEditingController(),
        answerControllers: []..insert(
            0,
            AnswerControllers(
              answerController: TextEditingController(),
              isCorrect: true,
            ),
          ),
      ),
    );

  final pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.createQuizBloc,
      child: BlocConsumer<CreateQuizBloc, CreateQuizState>(
        listener: (context, state) {
          if (state.submissionStatus.isSubmissionSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminDashboard(),
              ),
              (route) => false,
            );
          }
        },
        listenWhen: (previous, current) {
          if (!previous.submissionStatus.isSubmissionFailure &&
              current.submissionStatus.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(content: Text('Server Error')));
          }
          if (!previous.submissionStatus.isInvalid &&
              current.submissionStatus.isInvalid) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                  content: Text('Please add atleast 1 question')));
          }
          return true;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Questions'),
              actions: [
                IconButton(
                  onPressed: () {
                    final questionMapped = questionControllers
                        .map((e) => QuestionDomain(
                              question: e.question.text,
                              answers: e.answerControllers
                                  .map((e) => AnswerDomain(
                                      e.answerController.text, e.isCorrect))
                                  .toList(),
                            ))
                        .toList();

                    context
                        .read<CreateQuizBloc>()
                        .add(QuizSubmitted(questionMapped));
                  },
                  icon: const Icon(Icons.save),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      questionControllers.add(
                        QuestionControllers(
                          question: TextEditingController(),
                          answerControllers: []..insert(
                              0,
                              AnswerControllers(
                                answerController: TextEditingController(),
                                isCorrect: true,
                              ),
                            ),
                        ),
                      );
                      pageViewController.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.ease,
                      );
                    });
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: PageView.builder(
                      controller: pageViewController,
                      itemCount: questionControllers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CustomFormField(
                              headingText: 'Question',
                              hintText: 'Question',
                              obsecureText: false,
                              controller: questionControllers[index].question,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 10),
                            questionControllers.isEmpty
                                ? const SizedBox.shrink()
                                : Column(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: questionControllers[index]
                                            .answerControllers
                                            .length,
                                        itemBuilder: (context, answerIndex) {
                                          return Padding(
                                            key: ValueKey(answerIndex),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                CustomFormField(
                                                  headingText: answerIndex == 0
                                                      ? 'Correct Answer'
                                                      : 'Answers',
                                                  controller:
                                                      questionControllers[index]
                                                          .answerControllers[
                                                              answerIndex]
                                                          .answerController,
                                                  hintText: answerIndex == 0
                                                      ? 'Correct Answer'
                                                      : 'Answers',
                                                  obsecureText: false,
                                                  maxLines: 1,
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      CustomButton(
                                        onTap: () {
                                          setState(() {
                                            questionControllers[index]
                                                .answerControllers
                                                .add(
                                                  AnswerControllers(
                                                    answerController:
                                                        TextEditingController(),
                                                    isCorrect: false,
                                                  ),
                                                );
                                          });
                                        },
                                        text: 'Add Answers',
                                      )
                                    ],
                                  ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuestionControllers {
  QuestionControllers({
    required this.question,
    required this.answerControllers,
  });

  final TextEditingController question;
  final List<AnswerControllers> answerControllers;
}

class AnswerControllers {
  AnswerControllers({
    required this.answerController,
    required this.isCorrect,
  });

  final TextEditingController answerController;
  final bool isCorrect;
}
