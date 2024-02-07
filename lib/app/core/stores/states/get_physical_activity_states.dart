import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/list_physical_activities_model.dart';

sealed class GetPhysicalActivitiesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetPhysicalActivitiesInitialState extends GetPhysicalActivitiesState {}

final class GetPhysicalActivitiesLoadingState extends GetPhysicalActivitiesState {}

final class GetPhysicalActivitiesSuccessState extends GetPhysicalActivitiesState {
  final List<ListPhysicalActivitiesModel> physicalActivities;
  GetPhysicalActivitiesSuccessState(this.physicalActivities);
}

final class GetPhysicalActivitiesErrorState extends GetPhysicalActivitiesState {
  final String message;
  GetPhysicalActivitiesErrorState(this.message);
}
