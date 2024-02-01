import 'package:equatable/equatable.dart';

class PhysicalActivityModel extends Equatable {
  final String name;
  final String activityType;

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
      activityType: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': activityType,
    };
  }
}
