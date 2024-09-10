import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meal_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';

class MealResume extends StatelessWidget {
  final NutritionsByMealModel nutritions;

  const MealResume({super.key, required this.nutritions});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdaptiveText(
            text: nutritions.meal.title,
            textType: TextType.medium,
            fWeight: FWeight.bold,
          ),
          if (nutritions.energy != 0)
            AdaptiveText(
              text: 'Calorias: ${nutritions.energy} kcal',
              textType: TextType.small,
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
