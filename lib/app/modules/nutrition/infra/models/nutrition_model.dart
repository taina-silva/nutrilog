import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/modules/nutrition/infra/models/nutrition_type_model.dart';

class NutritionModel extends Equatable {
  final String name;
  final NutritionTypeModel nutritionType;

  const NutritionModel({
    required this.name,
    required this.nutritionType,
  });

  @override
  List<Object> get props => [name, nutritionType];

  @override
  bool get stringify => true;

  factory NutritionModel.fromMap(Map<String, dynamic> map) {
    return NutritionModel(
      name: map['name'],
      nutritionType: NutritionTypeModel(type: map['type']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': nutritionType.type,
    };
  }
}
