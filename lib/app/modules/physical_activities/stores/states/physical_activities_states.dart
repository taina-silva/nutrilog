import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_model.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_type_model.dart';

sealed class GetPhysicalActivitiesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetPhysicalActivitiesInitialState extends GetPhysicalActivitiesState {}

final class GetPhysicalActivitiesLoadingState extends GetPhysicalActivitiesState {}

final class GetPhysicalActivitiesSuccessState extends GetPhysicalActivitiesState {
  final List<PhysicalActivityTypeModel> types;
  final List<PhysicalActivityModel> physicalActivities;
  GetPhysicalActivitiesSuccessState(this.types, this.physicalActivities);
}

final class GetPhysicalActivitiesErrorState extends GetPhysicalActivitiesState {
  final String message;
  GetPhysicalActivitiesErrorState(this.message);
}
