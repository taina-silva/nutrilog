import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  final String msg;

  const ServerFailure([
    this.msg = "Ocorreu um erro inesperado. Tente novamente mais tarde.",
  ]) : super(msg);

  @override
  List<Object> get props => [message];
}

class EmailAlreadyInUseFailure extends Failure {
  final String msg;

  const EmailAlreadyInUseFailure([
    this.msg = "E-mail em uso! Tente realizar o registro com outro ou realizar login.",
  ]) : super(msg);

  @override
  List<Object> get props => [message];
}

class InvalidEmailFailure extends Failure {
  final String msg;

  const InvalidEmailFailure([
    this.msg = "E-mail inválido! Tente novamente.",
  ]) : super(msg);

  @override
  List<Object> get props => [message];
}

class WeakPasswordFailure extends Failure {
  final String msg;

  const WeakPasswordFailure([
    this.msg = "Senha fraca! Tente novamente com outra.",
  ]) : super(msg);

  @override
  List<Object> get props => [message];
}

class UserNotFoundFailure extends Failure {
  final String msg;

  const UserNotFoundFailure([
    this.msg = "Usuário não encontrado! Verifique suas credenciais.",
  ]) : super(msg);

  @override
  List<Object> get props => [message];
}

class WrongPasswordFailure extends Failure {
  final String msg;

  const WrongPasswordFailure([
    this.msg = "Senha incorreta! Tente novamente.",
  ]) : super(msg);

  @override
  List<Object> get props => [message];
}
