// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_model.dart';

class NutritionWithEnergyModel extends Equatable {
  final NutritionModel nutrition;
  final double energy;

  const NutritionWithEnergyModel({
    required this.nutrition,
    this.energy = 0,
  });

  @override
  List<Object> get props => [nutrition, energy];

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
      'energy': energy,
    };
  }

  NutritionWithEnergyModel copyWith({
    NutritionModel? nutrition,
    double? energy,
  }) {
    return NutritionWithEnergyModel(
      nutrition: nutrition ?? this.nutrition,
      energy: energy ?? this.energy,
    );
  }
}
