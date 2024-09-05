import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/day_log/day_log_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meal_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/duration.dart';
import 'package:nutrilog/app/core/utils/formatters/formatters.dart';

class DayLogResume extends StatelessWidget {
  final DayLogModel dayLog;

  const DayLogResume({super.key, required this.dayLog});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdaptiveText(text: formatDate(dayLog.date), textType: TextType.small),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(DefaultPadding.small),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(Layout.borderRadiusSmall)),
            border: Border.all(color: CColors.neutral500, width: Layout.borderWidth),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              itemFromDayLog(
                dayLog.physicalActivities.isEmpty
                    ? 'Atividades Físicas'
                    : 'Atividades Físicas (${totalHoursFromDurationsAsStr(dayLog.physicalActivities.map((e) => e.duration).toList())})',
                Icons.fitness_center_outlined,
                CColors.primaryActivity,
                () {
                  Modular.to.pushNamed(
                    'physical-activities/',
                    forRoot: true,
                    arguments: {'date': dayLog.date},
                  );
                },
              ),
              const SizedBox(height: 8),
              Builder(builder: (context) {
                double totalEnergy = 0;

                for (NutritionsByMealModel item in (dayLog.nutritions)) {
                  totalEnergy += item.energy;
                }

                return itemFromDayLog(
                  dayLog.nutritions.isEmpty ? 'Nutrição' : 'Nutrição ($totalEnergy Kcal)',
                  Icons.local_grocery_store_outlined,
                  CColors.primaryNutrition,
                  () {
                    Modular.to.pushNamed(
                      'nutritions/',
                      forRoot: true,
                      arguments: {'date': dayLog.date},
                    );
                  },
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget itemFromDayLog(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(DefaultPadding.small),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(Layout.borderRadiusBig)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: CColors.neutral0),
                const SizedBox(width: 16),
                AdaptiveText(
                  text: title,
                  textType: TextType.small,
                  color: CColors.neutral0,
                ),
              ],
            ),
            const SizedBox(width: 16),
            const Icon(Icons.arrow_forward_outlined, color: CColors.neutral0),
          ],
        ),
      ),
    );
  }
}
