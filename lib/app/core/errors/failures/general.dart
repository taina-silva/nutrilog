import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([
    String message = "Ocorreu um erro inesperado. Tente novamente mais tarde.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class GetGeneralPhysicalActivitiesFailure extends Failure {
  const GetGeneralPhysicalActivitiesFailure([
    String message = "Falha ao buscar atividades físicas.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class GetGeneralNutritionsFailure extends Failure {
  const GetGeneralNutritionsFailure([
    String message = "Falha ao buscar nutrições.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class RegisterNewPhysicalActitivyFailure extends Failure {
  const RegisterNewPhysicalActitivyFailure([
    String message = "Falha ao registrar nova atividade física.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class RegisterNewNutritionFailure extends Failure {
  const RegisterNewNutritionFailure([
    String message = "Falha ao registrar nova nutrição.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}
