import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/list_nutritions_model.dart';

sealed class GetNutritionState extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetNutritionInitialState extends GetNutritionState {}

final class GetNutritionLoadingState extends GetNutritionState {}

final class GetNutritionSuccessState extends GetNutritionState {
  final List<ListNutritionsModel> list;
  GetNutritionSuccessState(this.list);
}

final class GetNutritionErrorState extends GetNutritionState {
  final String message;
  GetNutritionErrorState(this.message);
}
