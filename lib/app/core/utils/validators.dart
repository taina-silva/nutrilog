import 'package:brasil_fields/brasil_fields.dart';

class Validators {
  String? basicValidator(String? value) {
    if (value == null || value.trim() == '') {
      return 'Valor inválido';
    }

    return null;
  }

  String? usernameValidator(String? value) {
    if (value == null || value.trim() == '') {
      return 'Nome de usuário inválido';
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.trim() == '') {
      return 'Senha inválida';
    } else if (value.trim().length < 6) {
      return 'Senha muito curta';
    }

    return null;
  }

  String? confirmPasswordValidator(String? value, String? original) {
    if (value == null || original == null || value.trim() == '' || original.trim() == '') {
      return 'Senha inválida';
    } else if (value.trim().length < 6) {
      return 'Senha muito curta';
    } else if (value != original) {
      return 'Senhas diferentes';
    }

    return null;
  }

  String? cpfOrCpnjValidator(String? value) {
    if (value == null || value.trim() == '') {
      return 'CPF ou CPNJ inválido';
    } else if (value.length == 14 && UtilBrasilFields.isCPFValido(value)) {
      return null;
    } else if (value.length == 18 && UtilBrasilFields.isCNPJValido(value)) {
      return null;
    }
    // login da apple
    else if (value == '123.456.789-10') {
      return null;
    }

    return 'CPF ou CPNJ inválido';
  }

  String? completeNameValidator(String? value) {
    if (value == null || value.trim() == '') {
      return 'É necessário digitar o nome';
    }

    return null;
  }

  String? phoneWithDDDValidator(String? value) {
    if (value == null || value.trim() == '') {
      return 'É necessário digitar o telefone';
    } else if (UtilBrasilFields.removeCaracteres(value).length < 10 ||
        UtilBrasilFields.removeCaracteres(value).length > 11) {
      return 'Telefone inválido';
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
