import 'package:nutrilog/app/core/errors/failures/general.dart';

class GetUserHistoryFailure extends Failure {
  const GetUserHistoryFailure([
    String message = "Erro ao buscar histórico! Tente novamente.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class RegisterPhysicalActivityFailure extends Failure {
  const RegisterPhysicalActivityFailure([
    String message = "Erro ao registrar atividade física! Tente novamente.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class RegisterNutritionFailure extends Failure {
  const RegisterNutritionFailure([
    String message = "Erro ao registrar alimento! Tente novamente.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class UnregisterPhysicalActivityFailure extends Failure {
  const UnregisterPhysicalActivityFailure([
    String message = "Erro ao desregistrar atividade física! Tente novamente.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}

class UnregisterNutritionFailure extends Failure {
  const UnregisterNutritionFailure([
    String message = "Erro ao desregistrar alimento! Tente novamente.",
  ]) : super(message);

  @override
  List<Object> get props => [message];
}
