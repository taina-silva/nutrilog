import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';

sealed class UnregisterPhysicalActivityState extends Equatable {
  @override
  List<Object> get props => [];
}

final class UnregisterPhysicalActivityInitialState extends UnregisterPhysicalActivityState {}

final class UnregisterPhysicalActivityLoadingState extends UnregisterPhysicalActivityState {
  final PhysicalActivityWithDurationModel pA;
  UnregisterPhysicalActivityLoadingState(this.pA);
}

final class UnregisterPhysicalActivitySuccessState extends UnregisterPhysicalActivityState {}

final class UnregisterPhysicalActivityErrorState extends UnregisterPhysicalActivityState {
  final String message;
  UnregisterPhysicalActivityErrorState(this.message);
}
