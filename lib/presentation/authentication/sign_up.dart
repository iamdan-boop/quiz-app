import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/app/styles/app_colors.dart';
import 'package:quiz_app/injection_container.dart';
import 'package:quiz_app/presentation/authentication/bloc/register/register_bloc.dart';
import 'package:quiz_app/presentation/authentication/bloc/register/register_event.dart';
import 'package:quiz_app/presentation/authentication/bloc/register/register_state.dart';
import 'package:quiz_app/presentation/authentication/sign_in.dart';
import 'package:quiz_app/presentation/widgets/custom_button.dart';
import 'package:quiz_app/presentation/widgets/custom_form_field.dart';
import 'package:quiz_app/presentation/widgets/custom_header.dart';
import 'package:quiz_app/presentation/widgets/custom_rich_text.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<RegisterBloc>(),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {},
          listenWhen: (prev, curr) {
            if (!prev.submissionStatus.isSubmissionFailure &&
                curr.submissionStatus.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(curr.message)));
            }
            return true;
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.blue,
                    ),
                    CustomHeader(
                      text: 'Sign Up.',
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signin()));
                      },
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.08,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: AppColors.whiteshade,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.09),
                              child: Image.asset('assets/images/login.png'),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomFormField(
                              headingText: 'Fullname',
                              hintText: 'Fullname',
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.text,
                              onChanged: (value) =>
                                  context.read<RegisterBloc>().add(
                                        RegisterNameChanged(name: value ?? ''),
                                      ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomFormField(
                              headingText: 'Email',
                              hintText: 'Email',
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.emailAddress,
                              onChanged: (value) => context
                                  .read<RegisterBloc>()
                                  .add(
                                    RegisterEmailChanged(email: value ?? ''),
                                  ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomFormField(
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.text,
                              onChanged: (value) =>
                                  context.read<RegisterBloc>().add(
                                        RegisterPasswordChanged(
                                            password: value ?? ''),
                                      ),
                              headingText: 'Password',
                              hintText: 'At least 8 Character',
                              obsecureText: true,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            state.submissionStatus.isSubmissionInProgress
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : CustomButton(
                                    onTap: () => context
                                        .read<RegisterBloc>()
                                        .add(RegisterSubmitted()),
                                    text: 'Sign Up',
                                  ),
                            CustomRichText(
                              discription: 'Already Have an account? ',
                              text: 'Log In here',
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Signin(),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
