import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_model.dart';

class NutritionWithEnergyModel extends Equatable {
  final NutritionModel nutrition;
  final double energy;

  const NutritionWithEnergyModel({
    required this.nutrition,
    required this.energy,
  });

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  bool get stringify => true;

  factory NutritionWithEnergyModel.fromMap(Map<String, dynamic> map) {
    return NutritionWithEnergyModel(
      nutrition: NutritionModel.fromMap(map['nutrition']),
      energy: map['energy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nutrition': nutrition.toMap(),
      'duration': energy,
    };
  }
}
