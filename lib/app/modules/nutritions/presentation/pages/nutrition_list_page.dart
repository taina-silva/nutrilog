import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:nutrilog/app/core/components/buttons/custom_button.dart';
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meals_of_day_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_one_meal_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/formatters/formatters.dart';
import 'package:nutrilog/app/modules/nutritions/presentation/components/nutritions_resume.dart';

class NutritionsListPage extends StatefulWidget {
  final DateTime date;
  final NutritionsByMealsOfDayModel? nutritions;

  const NutritionsListPage({
    Key? key,
    required this.date,
    required this.nutritions,
  }) : super(key: key);

  @override
  State<NutritionsListPage> createState() => _NutritionsListPageState();
}

class _NutritionsListPageState extends State<NutritionsListPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.nutritions == null) {
      return CustomScaffold(
        appBar: const CustomAppBar(title: Left('Nutrição')),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: DefaultMargin.horizontal,
            vertical: DefaultMargin.vertical,
          ),
          alignment: Alignment.center,
          child: AdaptiveText(
            text: 'Sem refeições registradas para o dia ${formatDate(widget.date)}',
            textType: TextType.medium,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return CustomScaffold(
      appBar: const CustomAppBar(title: Left('Nutrição')),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DefaultMargin.horizontal,
        ),
        child: CustomButton.primaryNutritionMedium(
          const ButtonParameters(text: 'Salvar alterações'),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: DefaultMargin.horizontal,
          vertical: DefaultMargin.vertical,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: widget.nutritions!.nutritions.values.length,
          itemBuilder: (context, index) {
            NutritionsOneMealModel nutritions =
                widget.nutritions!.nutritions.values.toList()[index];
            return NutritionsResume(nutritions: nutritions);
          },
        ),
      ),
    );
  }
}
