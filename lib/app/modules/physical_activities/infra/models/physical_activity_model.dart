import 'package:equatable/equatable.dart';

class PhysicalActivitiesModel extends Equatable {
  final String type;
  final List<String> list;

  const PhysicalActivitiesModel({
    required this.type,
    required this.list,
  });

  @override
  List<Object> get props => [type, list];

  @override
  bool get stringify => true;

  factory PhysicalActivitiesModel.fromMap(Map<String, dynamic> map) {
    return PhysicalActivitiesModel(
      type: map['type'],
      list: map['physical-activities'],
    );
  }
}
