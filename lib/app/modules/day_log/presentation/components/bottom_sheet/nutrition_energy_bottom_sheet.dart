import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/core/components/buttons/custom_button.dart';
import 'package:nutrilog/app/core/components/fields/common_field.dart';
import 'package:nutrilog/app/core/components/select/radios_select_widget.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/formatters/limited_input_formatter.dart';

class NutritionEnergyBottomSheet extends StatefulWidget {
  final double? totalEnergy;
  final List<NutritionWithEnergyModel> nutritions;
  final void Function(List<NutritionWithEnergyModel>, double) onOkCallback;

  const NutritionEnergyBottomSheet({
    super.key,
    required this.totalEnergy,
    required this.nutritions,
    required this.onOkCallback,
  });

  @override
  State<NutritionEnergyBottomSheet> createState() => _NutritionEnergyBottomSheetState();
}

class _NutritionEnergyBottomSheetState extends State<NutritionEnergyBottomSheet> {
  late double energy;
  late List<NutritionWithEnergyModel> list;
  bool energyAsTotal = true;

  @override
  void initState() {
    super.initState();
    energy = widget.totalEnergy ?? 0;
    list = widget.nutritions;
  }

  @override
  Widget build(BuildContext context) {
    return energyAsTotal
        ? SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: DefaultMargin.horizontal, vertical: DefaultMargin.vertical),
                child: Column(
                  children: [
                    _informEnergyByWidget(),
                    _commonFieldWidget(
                      energy,
                      (value) {
                        setState(() => energy = double.parse(value.replaceAll(',', '.')));
                      },
                    ),
                    const SizedBox(height: 32),
                    _finalButtonsWidget(),
                  ],
                ),
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(
                horizontal: DefaultMargin.horizontal, vertical: DefaultMargin.vertical),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _informEnergyByWidget(),
                Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AdaptiveText(
                                text: list[index].nutrition.name, textType: TextType.medium),
                            const SizedBox(height: 8),
                            _commonFieldWidget(
                              list[index].energy,
                              (value) {
                                List<NutritionWithEnergyModel> auxList = List.from(list);
                                NutritionWithEnergyModel? oldNutrition =
                                    auxList.firstWhereOrNull((n) => n == list[index]);
                                int idx = auxList.indexOf(oldNutrition!);
                                NutritionWithEnergyModel newNutrition = oldNutrition.copyWith(
                                    energy: double.parse(value.replaceAll(',', '.')));
                                auxList.replaceRange(idx, idx, [newNutrition]);

                                setState(() => list = auxList);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                _finalButtonsWidget(),
              ],
            ),
          );
  }

  Widget _finalButtonsWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton.secondaryNeutroSmall(
              ButtonParameters(
                text: 'VOLTAR',
                width: (MediaQuery.of(context).size.width - 2 * DefaultMargin.horizontal) * 0.45,
                onTap: () => Modular.to.pop(),
              ),
            ),
            CustomButton.primaryNeutroSmall(
              ButtonParameters(
                text: 'OK',
                width: (MediaQuery.of(context).size.width - 2 * DefaultMargin.horizontal) * 0.45,
                onTap: () => widget.onOkCallback(list, energy),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _informEnergyByWidget() {
    return Column(children: [
      const AdaptiveText(text: 'Informar calorias por:', textType: TextType.medium),
      const SizedBox(height: 16),
      RadiosSelectWidget<bool>(
        options: const [true, false],
        initialOption: energyAsTotal,
        text: (value) => value ? 'Total' : 'Item',
        onTap: (value) => setState(() => energyAsTotal = value),
        primaryColor: CColors.primaryNutrition,
        displayAsRow: true,
      ),
      const SizedBox(height: 24),
    ]);
  }

  Widget _commonFieldWidget(double initialValue, void Function(String) onChange) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width - 2 * DefaultMargin.horizontal) * 0.8,
          child: CommonField(
            initialValue: initialValue.toString().replaceAll('.', ','),
            onChange: onChange,
            inputFormatters: [LimitedInputFormatter(before: 4, after: 2)],
            keyboardType: TextInputType.number,
          ),
        ),
        const AdaptiveText(text: 'kcal', textType: TextType.medium)
      ],
    );
  }
}
