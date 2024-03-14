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

abstract class RegisterPhysicalActivityState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterPhysicalActivityInitialState extends RegisterPhysicalActivityState {}

class RegisterPhysicalActivityLoadingState extends RegisterPhysicalActivityState {}

class RegisterPhysicalActivitySuccessState extends RegisterPhysicalActivityState {}

class RegisterPhysicalActivityErrorState extends RegisterPhysicalActivityState {
  final String message;
  RegisterPhysicalActivityErrorState(this.message);
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

sealed class UnregisterPhysicalActivityState extends Equatable {
  @override
  List<Object> get props => [];
}

final class UnregisterPhysicalActivityInitialState extends UnregisterPhysicalActivityState {}

final class UnregisterPhysicalActivityLoadingState extends UnregisterPhysicalActivityState {}

final class UnregisterPhysicalActivitySuccessState extends UnregisterPhysicalActivityState {}

final class UnregisterPhysicalActivityErrorState extends UnregisterPhysicalActivityState {
  final String message;
  UnregisterPhysicalActivityErrorState(this.message);
}

sealed class UnregisterNutritionState extends Equatable {
  @override
  List<Object> get props => [];
}

final class UnregisterNutritionInitialState extends UnregisterNutritionState {}

final class UnregisterNutritionLoadingState extends UnregisterNutritionState {}

final class UnregisterNutritionSuccessState extends UnregisterNutritionState {}

final class UnregisterNutritionErrorState extends UnregisterNutritionState {
  final String message;
  UnregisterNutritionErrorState(this.message);
}
