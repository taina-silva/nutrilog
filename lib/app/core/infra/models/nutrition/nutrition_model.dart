import 'package:equatable/equatable.dart';

class NutritionModel extends Equatable {
  final String name;
  final String type;

  const NutritionModel({
    required this.name,
    required this.type,
  });

  @override
  List<Object> get props => [name, type];

  @override
  bool get stringify => true;

  factory NutritionModel.fromMap(Map<String, dynamic> map) {
    return NutritionModel(
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
