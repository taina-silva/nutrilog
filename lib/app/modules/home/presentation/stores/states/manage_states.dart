import 'package:equatable/equatable.dart';

sealed class ManageGeneralPhysicalActivitiesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ManageGeneralPhysicalActivitiesInitialState
    extends ManageGeneralPhysicalActivitiesState {}

final class ManageGeneralPhysicalActivitiesLoadingState
    extends ManageGeneralPhysicalActivitiesState {}

final class ManageGeneralPhysicalActivitiesSuccessState
    extends ManageGeneralPhysicalActivitiesState {}

final class ManageGeneralPhysicalActivitiesErrorState extends ManageGeneralPhysicalActivitiesState {
  final String message;
  ManageGeneralPhysicalActivitiesErrorState(this.message);
}

sealed class ManageGeneralNutritionsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ManageGeneralNutritionsInitialState extends ManageGeneralNutritionsState {}

final class ManageGeneralNutritionsLoadingState extends ManageGeneralNutritionsState {}

final class ManageGeneralNutritionsSuccessState extends ManageGeneralNutritionsState {}

final class ManageGeneralNutritionsErrorState extends ManageGeneralNutritionsState {
  final String message;
  ManageGeneralNutritionsErrorState(this.message);
}
