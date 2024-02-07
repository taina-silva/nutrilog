import 'package:equatable/equatable.dart';

class ListPhysicalActivitiesModel extends Equatable {
  final String type;
  final List<String> list;

  const ListPhysicalActivitiesModel({
    required this.type,
    required this.list,
  });

  @override
  List<Object> get props => [type, list];

  @override
  bool get stringify => true;

  factory ListPhysicalActivitiesModel.fromMap(Map<String, dynamic> map) {
    return ListPhysicalActivitiesModel(
      type: map['type'],
      list: map['physical-activities'],
    );
  }
}
