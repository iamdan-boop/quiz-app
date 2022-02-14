import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/injection_container.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/create/create_quiz_bloc.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/create/create_quiz_event.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/bloc/create/create_quiz_state.dart';
import 'package:quiz_app/presentation/dashboard/admin/quiz/create_page_view.dart';
import 'package:quiz_app/presentation/widgets/custom_button.dart';
import 'package:quiz_app/presentation/widgets/custom_form_field.dart';

import 'package:formz/formz.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({Key? key}) : super(key: key);

  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final controllers = <QuestionControllers>[];
  final createQuizBloc = getIt<CreateQuizBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quiz'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => createQuizBloc,
        child: BlocConsumer<CreateQuizBloc, CreateQuizState>(
          listener: (context, state) {
            if (state.submissionStatus.isSubmissionSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatePageView(
                    createQuizBloc: createQuizBloc,
                  ),
                ),
              );
            }
          },
          listenWhen: (prev, current) {
            if (!prev.submissionStatus.isInvalid &&
                current.submissionStatus.isInvalid) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    const SnackBar(content: Text('Fields cannot be empty')));
            }
            return true;
          },
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CustomFormField(
                    headingText: 'Quiz Name',
                    hintText: 'Quiz Name',
                    obsecureText: false,
                    onChanged: (value) => context
                        .read<CreateQuizBloc>()
                        .add(QuizNameChanged(value ?? '')),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    headingText: 'Quiz Description',
                    hintText: 'Quiz Description',
                    obsecureText: false,
                    maxLines: 4,
                    onChanged: (value) => context
                        .read<CreateQuizBloc>()
                        .add(QuizDescriptionChanged(value ?? '')),
                  ),
                  const SizedBox(height: 20),
                  const Spacer(),
                  CustomButton(
                    onTap: () =>
                        context.read<CreateQuizBloc>().add(QuizDescSubmitted()),
                    text: 'Next',
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class QuestionControllers extends Equatable {
  const QuestionControllers(this.questionController, this.answersController);

  final TextEditingController questionController;
  final List<DAnswer> answersController;

  @override
  List<Object?> get props => [questionController, answersController];
}

class DAnswer extends Equatable {
  const DAnswer({
    required this.isCorrect,
    required this.controller,
  });
  DAnswer copyWith({
    bool? isCorrect,
  }) {
    print(this.isCorrect);
    print(isCorrect);

    final copyWithValue = DAnswer(
      isCorrect: isCorrect ?? this.isCorrect,
      controller: controller,
    );

    print(copyWithValue);
    return copyWithValue;
  }

  final bool isCorrect;
  final TextEditingController controller;

  @override
  List<Object?> get props => [isCorrect, controller];
}

class SampleQuestion {
  SampleQuestion(this.questionName, this.answers);

  final String questionName;
  final List<SampleAnswer> answers;
}

class SampleAnswer {
  SampleAnswer(this.isCorrect, this.answer);

  SampleAnswer copyWith({
    bool? isCorrect,
  }) {
    print(this.isCorrect);
    print(isCorrect);

    final copyWithValue = SampleAnswer(isCorrect ?? this.isCorrect, answer);
    return copyWithValue;
  }

  final bool isCorrect;
  final String answer;
}
