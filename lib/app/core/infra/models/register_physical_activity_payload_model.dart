import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/utils/duration.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_type_model.dart';

class RegisterPhysicalActivityPayloadModel extends Equatable {
  final UniquePhysicalActivityModel physicalActivity;
  final Duration duration;

  const RegisterPhysicalActivityPayloadModel({
    required this.physicalActivity,
    required this.duration,
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool get stringify => true;

  factory RegisterPhysicalActivityPayloadModel.fromMap(Map<String, dynamic> map) {
    return RegisterPhysicalActivityPayloadModel(
      physicalActivity: UniquePhysicalActivityModel.fromMap(map['physical-activity']),
      duration: durationFromString(map['duration']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'physical-activity': physicalActivity.toMap(),
      'duration': durationToString(duration),
    };
  }
}
