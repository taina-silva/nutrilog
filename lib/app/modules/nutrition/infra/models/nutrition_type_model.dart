import 'package:equatable/equatable.dart';

class NutritionTypeModel extends Equatable {
  final String type;

  const NutritionTypeModel({
    required this.type,
  });

  @override
  List<Object> get props => [type];

  @override
  bool get stringify => true;

  factory NutritionTypeModel.fromMap(dynamic t) {
    return NutritionTypeModel(type: t);
  }
}
