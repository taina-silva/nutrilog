import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/core/components/buttons/custom_button.dart';
import 'package:nutrilog/app/core/components/select/radios_select_widget.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/show_time_picker.dart';

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

  Future<void> onSetTimeCallback() async {
    TimeOfDay? time = await showCustomTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() => selectedTime = time);
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
              onTap: (mT) => setState(() => selectedMeal = mT),
              primaryColor: CColors.primaryNutrition,
            ),
            SizedBox(height: selectedTime == null ? 32 : 48),
            if (selectedTime != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_timeWidget()],
              ),
            if (selectedTime == null)
              CustomButton.secondaryNutritionMedium(
                ButtonParameters(
                  text: 'Selecionar horário',
                  onTap: onSetTimeCallback,
                  prefixIcon: Icons.schedule_outlined,
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

  Widget _timeWidget() {
    Widget partTimeWidget(String value) {
      return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: DefaultPadding.large, vertical: DefaultPadding.small),
        decoration: const BoxDecoration(
          color: CColors.neutral350,
          borderRadius: BorderRadius.all(Radius.circular(Layout.borderRadiusSmall)),
        ),
        child: AdaptiveText(text: value, textType: TextType.large),
      );
    }

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: DefaultPadding.nano, bottom: DefaultPadding.large),
          child: Row(
            children: [
              partTimeWidget(
                  selectedTime!.hour < 10 ? '0${selectedTime!.hour}' : '${selectedTime!.hour}'),
              const SizedBox(width: 16),
              const AdaptiveText(text: ':', textType: TextType.large, fWeight: FWeight.bold),
              const SizedBox(width: 16),
              partTimeWidget(selectedTime!.minute < 10
                  ? '0${selectedTime!.minute}'
                  : '${selectedTime!.minute}'),
              const SizedBox(width: 8),
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: onSetTimeCallback,
            child: Container(
              padding: const EdgeInsets.all(DefaultPadding.nano),
              decoration: const BoxDecoration(
                color: CColors.primaryNutrition,
                borderRadius: BorderRadius.all(Radius.circular(Layout.borderRadiusBig)),
              ),
              child: const Icon(Icons.edit_outlined, color: CColors.neutral0),
            ),
          ),
        ),
      ],
    );
  }
}
