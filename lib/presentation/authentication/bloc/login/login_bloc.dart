import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/domain/inputs/email.dart';
import 'package:quiz_app/domain/inputs/generic_string_input.dart';
import 'package:quiz_app/infrastructure/authentication_repository.dart';
import 'package:quiz_app/presentation/authentication/bloc/login/login_event.dart';
import 'package:quiz_app/presentation/authentication/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authenticationRepository) : super(const LoginState()) {
    on<LoginEmailChanged>(
      (event, emit) => emit(
        state.copyWith(email: Email.dirty(event.email)),
      ),
    );
    on<LoginPasswordChanged>(
      (event, emit) => emit(
        state.copyWith(password: GenericStringInput.dirty(event.password)),
      ),
    );
    on<LoginSubmitted>(_loginUserWithEmailAndPassword);
  }

  Future<void> _loginUserWithEmailAndPassword(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
      submissionStatus: FormzStatus.submissionInProgress,
      message: '',
    ));
    if (state.email.invalid) {
      emit(
        state.copyWith(
          message: 'Email badly formatted',
          submissionStatus: FormzStatus.invalid,
        ),
      );
      return;
    }
    if (state.password.invalid) {
      emit(
        state.copyWith(
          message: 'Password Cannot Be Empty',
          submissionStatus: FormzStatus.invalid,
        ),
      );
      return;
    }
    final validate = Formz.validate([
      state.password,
      state.email,
    ]);
    if (!validate.isValidated) {
      emit(state.copyWith(
        message: 'Fields Cannot be empty',
        submissionStatus: FormzStatus.invalid,
      ));
      return;
    }
    try {
      await _authenticationRepository.login(
        email: state.email.value,
        password: state.password.value,
      );
      return emit(
        state.copyWith(submissionStatus: FormzStatus.submissionSuccess),
      );
    } on DioError {
      return emit(
        state.copyWith(
          message: 'Invalid Email or Password',
          submissionStatus: FormzStatus.submissionFailure,
        ),
      );
    }
  }

  final AuthenticationRepository _authenticationRepository;
}
