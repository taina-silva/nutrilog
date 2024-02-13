import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_model.dart';
import 'package:nutrilog/app/core/utils/duration.dart';

class PhysicalActivityWithDurationModel extends Equatable {
  final PhysicalActivityModel physicalActivity;
  final Duration duration;

  const PhysicalActivityWithDurationModel({
    required this.physicalActivity,
    required this.duration,
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool get stringify => true;

  factory PhysicalActivityWithDurationModel.fromMap(Map<String, dynamic> map) {
    return PhysicalActivityWithDurationModel(
      physicalActivity: PhysicalActivityModel.fromMap(map['physical-activity']),
      duration: durationFromString(map['duration']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'physical-activity': physicalActivity.toMap(),
      'duration': duration.toString(),
    };
  }
}
