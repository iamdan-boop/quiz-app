import 'package:formz/formz.dart';

enum GenericStringInputValidationError { empty }

class GenericStringInput
    extends FormzInput<String, GenericStringInputValidationError> {
  const GenericStringInput.pure() : super.pure('');
  const GenericStringInput.dirty([String value = '']) : super.dirty(value);

  @override
  GenericStringInputValidationError? validator(String? value) {
    if (value == null && value!.isEmpty) {
      return GenericStringInputValidationError.empty;
    }
    return null;
  }
}
