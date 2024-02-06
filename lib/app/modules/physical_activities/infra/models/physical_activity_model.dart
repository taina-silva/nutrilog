import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_type_model.dart';

class PhysicalActivityModel extends Equatable {
  final String name;
  final PhysicalActivityTypeModel activityType;

  const PhysicalActivityModel({
    required this.name,
    required this.activityType,
  });

  @override
  List<Object> get props => [name, activityType];

  @override
  bool get stringify => true;

  factory PhysicalActivityModel.fromMap(Map<String, dynamic> map) {
    return PhysicalActivityModel(
      name: map['name'],
      activityType: PhysicalActivityTypeModel(type: map['type']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': activityType.type,
    };
  }
}
