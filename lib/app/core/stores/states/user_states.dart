import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/models/day_log/day_log_model.dart';

abstract class GetUserDayLogState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserDayLogInitialState extends GetUserDayLogState {}

class GetUserDayLogLoadingState extends GetUserDayLogState {}

class GetUserDayLogSuccessState extends GetUserDayLogState {
  final List<DayLogModel> list;
  GetUserDayLogSuccessState(this.list);
}

class GetUserDayLogErrorState extends GetUserDayLogState {
  final String message;
  GetUserDayLogErrorState(this.message);
}

abstract class RegisterPhysicalActitityState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterPhysicalActitityInitialState extends RegisterPhysicalActitityState {}

class RegisterPhysicalActitityLoadingState extends RegisterPhysicalActitityState {}

class RegisterPhysicalActititySuccessState extends RegisterPhysicalActitityState {}

class RegisterPhysicalActitityErrorState extends RegisterPhysicalActitityState {
  final String message;
  RegisterPhysicalActitityErrorState(this.message);
}

abstract class RegisterNutritionState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterNutritionInitialState extends RegisterNutritionState {}

class RegisterNutritionLoadingState extends RegisterNutritionState {}

class RegisterNutritionSuccessState extends RegisterNutritionState {}

class RegisterNutritionErrorState extends RegisterNutritionState {
  final String message;
  RegisterNutritionErrorState(this.message);
}
