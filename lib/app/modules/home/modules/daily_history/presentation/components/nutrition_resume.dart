import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meal_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/string.dart';

class NutritionResume extends StatelessWidget {
  final NutritionsByMealModel nutritions;
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
    double nameContainerWidth = MediaQuery.of(context).size.width -
        2 * DefaultMargin.horizontal -
        iconContainerWidth -
        2 * DefaultPadding.nano -
        40;

    return Column(
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
        ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              NutritionWithEnergyModel nutrition = nutritions.nutritions[index];

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: iconContainerWidth,
                    height: containerHeight,
                    padding: const EdgeInsets.all(DefaultPadding.nano),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: CColors.primaryNutrition, width: Layout.borderWidth),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(Layout.borderRadiusSmall),
                        bottomLeft: Radius.circular(Layout.borderRadiusSmall),
                      ),
                    ),
                    child: Image.asset(
                      '${Assets.icons}/nutritions/${removeAccentsFromStr(nutrition.nutrition.type)}.png',
                      color: CColors.primaryNutrition,
                    ),
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
                            SizedBox(
                              width: nameContainerWidth,
                              child: AdaptiveText(
                                text: nutrition.nutrition.name,
                                textType: TextType.small,
                                color: CColors.neutral0,
                              ),
                            ),
                            if (nutrition.energy != 0)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: AdaptiveText(
                                  text: '${nutrition.energy} kcal',
                                  textType: TextType.large,
                                  fWeight: FWeight.bold,
                                  color: CColors.neutral0,
                                ),
                              ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                  color: CColors.neutral0,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(Layout.borderRadiusBig))),
                              child: AdaptiveText(
                                text: nutrition.nutrition.type,
                                textType: TextType.nano,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // const Icon(Icons.edit_outlined, color: CColors.neutral0, size: 32),
                            GestureDetector(
                              onTap: () => ondeDeleteCallback(nutritions.meal, nutrition),
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
            },
            itemCount: nutritions.nutritions.length,
            shrinkWrap: true),
      ],
    );
  }
}
