import 'package:email_validator/email_validator.dart';

class Validators {
  static bool _isEmptyOrNull(String? value) => value?.trim().isEmpty ?? true;

  String? basicValidator(String? value) {
    if (value == null || value.trim() == '') {
      return 'Valor inválido';
    }

    return null;
  }

  static String? emailValidator(String? value) {
    if (_isEmptyOrNull(value)) {
      return "É necessário digitar o e-mail!";
    } else if (!EmailValidator.validate(value!.trim())) {
      return "E-mail inválido";
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (_isEmptyOrNull(value)) {
      return 'Senha inválida';
    } else if (value!.trim().length < 6) {
      return 'Senha muito curta';
    }

    return null;
  }

  static String? confirmPasswordValidator(String? value, String? original) {
    if (_isEmptyOrNull(value) || _isEmptyOrNull(original)) {
      return 'Senha inválida';
    } else if (value!.trim().length < 6) {
      return 'Senha muito curta';
    } else if (value != original) {
      return 'Senhas diferentes';
    }

    return null;
  }
}

bool isDate(String str) {
  try {
    DateTime.parse(str);

    return true;
  } catch (e) {
    return false;
  }
}
