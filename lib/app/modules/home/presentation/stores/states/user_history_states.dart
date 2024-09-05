import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/models/day_log/day_log_model.dart';

abstract class GetHistoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetHistoryInitialState extends GetHistoryState {}

class GetHistoryLoadingState extends GetHistoryState {}

class GetHistorySuccessState extends GetHistoryState {
  final List<DayLogModel> list;
  GetHistorySuccessState(this.list);
}

class GetHistoryErrorState extends GetHistoryState {
  final String message;
  GetHistoryErrorState(this.message);
}

abstract class ManagePhysicalActivityState extends Equatable {
  @override
  List<Object> get props => [];
}

class ManagePhysicalActivityInitialState extends ManagePhysicalActivityState {}

class ManagePhysicalActivityLoadingState extends ManagePhysicalActivityState {}

class ManagePhysicalActivitySuccessState extends ManagePhysicalActivityState {}

class ManagePhysicalActivityErrorState extends ManagePhysicalActivityState {
  final String message;
  ManagePhysicalActivityErrorState(this.message);
}

abstract class ManageNutritionState extends Equatable {
  @override
  List<Object> get props => [];
}

class ManageNutritionInitialState extends ManageNutritionState {}

class ManageNutritionLoadingState extends ManageNutritionState {}

class ManageNutritionSuccessState extends ManageNutritionState {}

class ManageNutritionErrorState extends ManageNutritionState {
  final String message;
  ManageNutritionErrorState(this.message);
}
