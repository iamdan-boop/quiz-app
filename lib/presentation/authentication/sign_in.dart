import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/app/styles/app_colors.dart';
import 'package:quiz_app/injection_container.dart';
import 'package:quiz_app/presentation/authentication/bloc/login/login_bloc.dart';
import 'package:quiz_app/presentation/authentication/bloc/login/login_event.dart';
import 'package:quiz_app/presentation/authentication/bloc/login/login_state.dart';
import 'package:quiz_app/presentation/authentication/sign_up.dart';
import 'package:quiz_app/presentation/widgets/custom_button.dart';
import 'package:quiz_app/presentation/widgets/custom_form_field.dart';
import 'package:quiz_app/presentation/widgets/custom_header.dart';
import 'package:quiz_app/presentation/widgets/custom_rich_text.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<LoginBloc>(),
        child: BlocConsumer<LoginBloc, LoginState>(
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
                    text: 'Log In.',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ),
                      );
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
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.09),
                            child: Image.asset('assets/images/login.png'),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomFormField(
                            headingText: 'Email',
                            hintText: 'Email',
                            obsecureText: false,
                            suffixIcon: const SizedBox(),
                            onChanged: (value) => context
                                .read<LoginBloc>()
                                .add(LoginEmailChanged(email: value ?? '')),
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomFormField(
                            headingText: 'Password',
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text,
                            hintText: 'At least 8 Character',
                            obsecureText: true,
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.visibility),
                                onPressed: () {}),
                            onChanged: (value) => context.read<LoginBloc>().add(
                                  LoginPasswordChanged(password: value ?? ''),
                                ),
                          ),
                          const SizedBox(height: 20),
                          state.submissionStatus.isSubmissionInProgress
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  onTap: () => context
                                      .read<LoginBloc>()
                                      .add(LoginSubmitted()),
                                  text: 'Sign In',
                                ),
                          CustomRichText(
                            discription: "Don't already Have an account? ",
                            text: 'Sign Up',
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUp(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
