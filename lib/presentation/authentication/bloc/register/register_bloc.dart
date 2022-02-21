import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/domain/inputs/email.dart';
import 'package:quiz_app/domain/inputs/generic_string_input.dart';
import 'package:quiz_app/domain/inputs/password.dart';
import 'package:quiz_app/infrastructure/authentication_repository.dart';
import 'package:quiz_app/presentation/authentication/bloc/register/register_event.dart';
import 'package:quiz_app/presentation/authentication/bloc/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const RegisterState()) {
    on<RegisterEmailChanged>(
      (event, emit) => emit(state.copyWith(email: Email.dirty(event.email))),
    );
    on<RegisterNameChanged>(
      (event, emit) => emit(
        state.copyWith(name: GenericStringInput.dirty(event.name)),
      ),
    );
    on<RegisterPasswordChanged>(
      (event, emit) => emit(
        state.copyWith(
          password: Password.dirty(event.password),
        ),
      ),
    );
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(
      submissionStatus: FormzStatus.submissionInProgress,
      message: '',
    ));
    final validate = Formz.validate([
      state.email,
      state.name,
      state.password,
    ]);
    if (!validate.isValidated) {
      emit(
        state.copyWith(
          submissionStatus: FormzStatus.invalid,
          message: 'Fields cannot be empty',
        ),
      );
      return;
    }
    try {
      await _authenticationRepository.register(
        name: state.name.value,
        email: state.email.value,
        password: state.password.value,
      );
      return emit(
        state.copyWith(
          submissionStatus: FormzStatus.submissionSuccess,
        ),
      );
    } catch (e) {
      print(e);
      return emit(
        state.copyWith(
          submissionStatus: FormzStatus.submissionFailure,
          message: 'Email or Password already taken',
        ),
      );
    }
  }

  final AuthenticationRepository _authenticationRepository;
}
