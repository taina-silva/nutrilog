import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

class NutritionTag extends StatelessWidget {
  final List<NutritionModel> nutritions;
  final void Function(NutritionModel) onDeleteCallback;

  const NutritionTag({
    super.key,
    required this.nutritions,
    required this.onDeleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Wrap(
        spacing: 2,
        runSpacing: 4,
        children: nutritions.map((n) {
          return Container(
            padding: const EdgeInsets.all(DefaultPadding.nano),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(Layout.borderRadiusMedium)),
              border: Border.all(color: CColors.neutral400),
            ),
            child: Wrap(
              children: [
                AdaptiveText(text: n.name, textType: TextType.small),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () => onDeleteCallback(n),
                  child: const Icon(Icons.close, color: CColors.error500),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
