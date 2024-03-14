import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/components/divider/custom_divider.dart';
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/components/toasts/toasts.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_by_meals_of_day_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_one_meal_model.dart';
import 'package:nutrilog/app/core/stores/states/user_states.dart';
import 'package:nutrilog/app/core/stores/user_store.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/formatters/formatters.dart';
import 'package:nutrilog/app/modules/nutritions/presentation/components/nutrition_resume.dart';

class NutritionsListPage extends StatefulWidget {
  final DateTime date;
  final NutritionsByMealOfDayModel? nutritions;

  const NutritionsListPage({
    Key? key,
    required this.date,
    required this.nutritions,
  }) : super(key: key);

  @override
  State<NutritionsListPage> createState() => _NutritionsListPageState();
}

class _NutritionsListPageState extends State<NutritionsListPage> {
  final userStore = Modular.get<UserStore>();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    reactions = [
      reaction((_) => userStore.unregisterNutritionState, (UnregisterNutritionState state) async {
        if (state is UnregisterNutritionErrorState) {
          errorToast(context, 'Falha ao deletar alimento: ${state.message}');
        } else if (state is UnregisterNutritionSuccessState) {
          userStore.getUserDayLog();
        }
      }),
    ];
  }

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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 8, right: 8),
            decoration: const BoxDecoration(
                color: CColors.primaryNutrition,
                borderRadius: BorderRadius.all(Radius.circular(Layout.borderRadiusBig))),
            child: const Icon(Icons.add_outlined, color: CColors.neutral0),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: DefaultMargin.horizontal,
          vertical: DefaultMargin.vertical,
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(0),
          separatorBuilder: (context, index) => const CustomDivider(),
          itemCount: widget.nutritions!.nutritions.values.length,
          itemBuilder: (context, index) {
            NutritionsOneMealModel nutritions =
                widget.nutritions!.nutritions.values.toList()[index];
            return NutritionResume(
              nutritions: nutritions,
              ondeDeleteCallback: (mealType, nutrition) =>
                  userStore.unregisterNutrition(widget.date, mealType, nutrition),
            );
          },
        ),
      ),
    );
  }
}
