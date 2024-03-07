import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_one_meal_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

class NutritionsResume extends StatelessWidget {
  final NutritionsOneMealModel nutritions;

  const NutritionsResume({
    Key? key,
    required this.nutritions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            text: 'Calorias: ${nutritions.energy}',
            textType: TextType.small,
          ),
        const SizedBox(height: 16),
        Column(
          children: nutritions.nutritions.map((n) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(DefaultPadding.nano),
                    margin: const EdgeInsets.only(
                      bottom: DefaultPadding.normal,
                      right: DefaultPadding.nano,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: CColors.primaryNutrition, width: Layout.borderWidth),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(Layout.borderRadiusSmall)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AdaptiveText(
                          text: n.nutrition.name,
                          textType: TextType.medium,
                          fWeight: FWeight.bold,
                        ),
                        if (n.energy != 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: AdaptiveText(
                              text: 'Calorias: ${n.energy}',
                              textType: TextType.small,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(DefaultPadding.nano),
                      decoration: const BoxDecoration(
                        color: CColors.primaryNutrition,
                        borderRadius: BorderRadius.all(Radius.circular(Layout.borderRadiusBig)),
                      ),
                      child: const Icon(Icons.edit_outlined, color: CColors.neutral0),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
