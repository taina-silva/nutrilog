import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/modules/nutrition/infra/models/nutrition_model.dart';
import 'package:nutrilog/app/modules/nutrition/infra/models/nutrition_type_model.dart';

sealed class GetNutritionsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetNutritionsInitialState extends GetNutritionsState {}

final class GetNutritionsLoadingState extends GetNutritionsState {}

final class GetNutritionsSuccessState extends GetNutritionsState {
  final List<NutritionTypeModel> types;
  final List<NutritionModel> nutritions;
  GetNutritionsSuccessState(this.types, this.nutritions);
}

final class GetNutritionsErrorState extends GetNutritionsState {
  final String message;
  GetNutritionsErrorState(this.message);
}
