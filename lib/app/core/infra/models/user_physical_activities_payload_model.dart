import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/models/register_physical_activity_payload_model.dart';

class UserPhysicalActivitiesPayloadModel extends Equatable {
  final DateTime date;
  final List<RegisterPhysicalActivityPayloadModel> physicalActivities;

  const UserPhysicalActivitiesPayloadModel({
    required this.date,
    required this.physicalActivities,
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool get stringify => true;

  factory UserPhysicalActivitiesPayloadModel.fromMap(Map<String, dynamic> map) {
    return UserPhysicalActivitiesPayloadModel(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      physicalActivities: (map['physical-activities'] as List)
          .map((e) => RegisterPhysicalActivityPayloadModel.fromMap(e))
          .toList(),
    );
  }
}
