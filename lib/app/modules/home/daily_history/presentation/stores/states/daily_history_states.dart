import 'package:equatable/equatable.dart';

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
