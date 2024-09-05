import 'package:nutrilog/app/core/errors/failures/general.dart';

class EmailAlreadyInUseFailure extends Failure {
  const EmailAlreadyInUseFailure([
    String message = "E-mail em uso! Tente realizar o registro com outro ou realizar login.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class InvalidLoginCredentialsFailure extends Failure {
  const InvalidLoginCredentialsFailure([
    String message = "Credenciais inválidas! Tente novamente.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class InvalidEmailFailure extends Failure {
  const InvalidEmailFailure([
    String message = "E-mail inválido! Tente novamente.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class WeakPasswordFailure extends Failure {
  const WeakPasswordFailure([
    String message = "Senha fraca! Tente novamente com outra.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure([
    String message = "Usuário não encontrado! Verifique suas credenciais.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class WrongPasswordFailure extends Failure {
  const WrongPasswordFailure([
    String message = "Senha incorreta! Tente novamente.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class NoPermissionsFailure extends Failure {
  const NoPermissionsFailure([
    String message = "Sem permissões! Tente novamente.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}
