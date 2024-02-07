import 'package:equatable/equatable.dart';

class UniquePhysicalActivityModel extends Equatable {
  final String type;
  final String name;

  const UniquePhysicalActivityModel({
    required this.type,
    required this.name,
  });

  @override
  List<Object> get props => [type, name];

  @override
  bool get stringify => true;

  factory UniquePhysicalActivityModel.fromMap(Map<String, dynamic> map) {
    return UniquePhysicalActivityModel(
      name: map['name'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
    };
  }
}
