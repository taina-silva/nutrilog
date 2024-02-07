import 'package:equatable/equatable.dart';

class PhysicalActivityModel extends Equatable {
  final String type;
  final String name;

  const PhysicalActivityModel({
    required this.type,
    required this.name,
  });

  @override
  List<Object> get props => [type, name];

  @override
  bool get stringify => true;

  factory PhysicalActivityModel.fromMap(Map<String, dynamic> map) {
    return PhysicalActivityModel(
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
