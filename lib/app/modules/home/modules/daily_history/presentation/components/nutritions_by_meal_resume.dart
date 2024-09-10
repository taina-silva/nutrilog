import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meal_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/string.dart';

class NutritionsByMealResume extends StatelessWidget {
  final NutritionsByMealModel nutritions;
  final void Function(MealType, NutritionWithEnergyModel) ondeDeleteCallback;
  final Tuple2<MealType, NutritionWithEnergyModel>? nutritionBeingDeleted;

  const NutritionsByMealResume({
    Key? key,
    required this.nutritions,
    required this.ondeDeleteCallback,
    required this.nutritionBeingDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = 32;
    double containerHeight = 88;
    double iconContainerWidth = 72;
    double infoContainerWidth =
        MediaQuery.of(context).size.width - 2 * DefaultMargin.horizontal - 80;
    double nameContainerWidth = MediaQuery.of(context).size.width -
        2 * DefaultMargin.horizontal -
        iconContainerWidth -
        2 * DefaultPadding.nano -
        40;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final nutrition = nutritions.nutritions[index];

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
                    nutritionBeingDeleted == Tuple2(nutritions.meal, nutrition)
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              width: iconSize,
                              height: iconSize,
                              child: const CircularProgressIndicator(color: CColors.neutral0),
                            ),
                          )
                        : Column(
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
        childCount: nutritions.nutritions.length,
      ),
    );
  }
}
