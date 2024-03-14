import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_one_meal_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

class NutritionResume extends StatelessWidget {
  final NutritionsOneMealModel nutritions;
  final void Function(MealType, NutritionWithEnergyModel) ondeDeleteCallback;

  const NutritionResume({
    Key? key,
    required this.nutritions,
    required this.ondeDeleteCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerHeight = 88;
    double iconContainerWidth = 72;
    double infoContainerWidth =
        MediaQuery.of(context).size.width - 2 * DefaultMargin.horizontal - 80;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdaptiveText(
          text: nutritions.mealType.title,
          textType: TextType.medium,
          fWeight: FWeight.bold,
        ),
        if (nutritions.energy != 0)
          AdaptiveText(
            text: 'Calorias: ${nutritions.energy} kcal',
            textType: TextType.small,
          ),
        const SizedBox(height: 16),
        Column(
          children: nutritions.nutritions.map((n) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: iconContainerWidth,
                  height: containerHeight,
                  padding: const EdgeInsets.all(DefaultPadding.nano),
                  decoration: BoxDecoration(
                    border: Border.all(color: CColors.primaryNutrition, width: Layout.borderWidth),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(Layout.borderRadiusSmall),
                      bottomLeft: Radius.circular(Layout.borderRadiusSmall),
                    ),
                  ),
                  child:
                      const Icon(Icons.breakfast_dining, color: CColors.primaryNutrition, size: 48),
                ),
                Container(
                  width: infoContainerWidth,
                  height: containerHeight,
                  padding: const EdgeInsets.all(DefaultPadding.nano),
                  margin: const EdgeInsets.only(
                    bottom: DefaultPadding.normal,
                    right: DefaultPadding.nano,
                  ),
                  decoration: const BoxDecoration(
                    color: CColors.primaryNutrition,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Layout.borderRadiusSmall),
                      bottomRight: Radius.circular(Layout.borderRadiusSmall),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AdaptiveText(
                            text: n.nutrition.name,
                            textType: TextType.small,
                            color: CColors.neutral0,
                          ),
                          if (n.energy != 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: AdaptiveText(
                                text: '${n.energy} kcal',
                                textType: TextType.large,
                                fWeight: FWeight.bold,
                                color: CColors.neutral0,
                              ),
                            ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.edit_outlined, color: CColors.neutral0, size: 32),
                          GestureDetector(
                            onTap: () => ondeDeleteCallback(nutritions.mealType, n),
                            child: const Icon(Icons.delete_outlined,
                                color: CColors.neutral0, size: 32),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        )
      ],
    );
  }
}
