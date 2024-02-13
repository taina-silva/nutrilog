import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/core/components/buttons/custom_button.dart';
import 'package:nutrilog/app/core/components/select/radios_select_widget.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

class NutritionMealTypeBottomSheet extends StatefulWidget {
  final MealType initialMealValue;
  final TimeOfDay? initialTimeValue;
  final void Function(MealType) onOkCallback;

  const NutritionMealTypeBottomSheet({
    super.key,
    required this.initialMealValue,
    required this.initialTimeValue,
    required this.onOkCallback,
  });

  @override
  State<NutritionMealTypeBottomSheet> createState() => _NutritionMealTypeBottomSheetState();
}

class _NutritionMealTypeBottomSheetState extends State<NutritionMealTypeBottomSheet> {
  late MealType selectedMeal;
  late TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();

    selectedMeal = widget.initialMealValue;
    selectedTime = widget.initialTimeValue;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: ScreenMargin.horizontal, vertical: ScreenMargin.vertical),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdaptiveText(text: 'Selecionar refeição', textType: TextType.medium),
            const SizedBox(height: 32),
            RadiosSelectWidget<MealType>(
              options: MealType.values,
              initialOption: MealType.breakfast,
              text: (mT) => mT.title,
              onTap: (item) {
                setState(() => selectedMeal = item);
              },
              primaryColor: CColors.primaryNutrition,
            ),
            const SizedBox(height: 32),
            Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: CColors.neutral900,
                  onPrimary: CColors.neutral0,
                  onSurface: CColors.neutral900,
                ),
              ),
              child: TimePickerDialog(
                initialTime: selectedTime ?? TimeOfDay.now(),
                cancelText: 'Cancelar',
                errorInvalidText: 'Hora inválida.',
                hourLabelText: 'Hora (24h)',
                minuteLabelText: 'Minuto',
                initialEntryMode: TimePickerEntryMode.input,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton.secondaryNeutroSmall(
                  ButtonParameters(
                    text: 'VOLTAR',
                    width: (MediaQuery.of(context).size.width - 2 * ScreenMargin.horizontal) * 0.45,
                    onTap: () => Modular.to.pop(),
                  ),
                ),
                CustomButton.primaryNeutroSmall(
                  ButtonParameters(
                    text: 'OK',
                    width: (MediaQuery.of(context).size.width - 2 * ScreenMargin.horizontal) * 0.45,
                    onTap: () => widget.onOkCallback(selectedMeal),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
