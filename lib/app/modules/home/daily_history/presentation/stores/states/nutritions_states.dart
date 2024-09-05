import 'package:equatable/equatable.dart';

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
