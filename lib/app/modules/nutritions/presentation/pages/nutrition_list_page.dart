import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/components/divider/custom_divider.dart';
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/components/toasts/toasts.dart';
import 'package:nutrilog/app/core/infra/models/day_log/day_log_model.dart';
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

  const NutritionsListPage({
    Key? key,
    required this.date,
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
            child: InkWell(
              onTap: () {
                Modular.to.pushNamed(
                  'day-log/nutrition',
                  forRoot: true,
                  arguments: {'date': widget.date},
                );
              },
              child: const Icon(Icons.add_outlined, color: CColors.neutral0),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: DefaultMargin.horizontal,
          vertical: DefaultMargin.vertical,
        ),
        child: Observer(builder: (context) {
          if (userStore.getUserDayLogState is GetUserDayLogInitialState) return const SizedBox();

          if (userStore.getUserDayLogState is GetUserDayLogLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userStore.getUserDayLogState is GetUserDayLogErrorState) {
            return _noNutritionsWidget();
          }

          List<DayLogModel> dayLogs =
              (userStore.getUserDayLogState as GetUserDayLogSuccessState).list;
          DayLogModel? dayLog = dayLogs.firstWhereOrNull((e) => e.date == widget.date);
          NutritionsByMealOfDayModel? nutritions = dayLog?.nutritions;

          if (nutritions?.nutritions.isEmpty ?? true) return _noNutritionsWidget();

          return ListView.separated(
            padding: const EdgeInsets.all(0),
            separatorBuilder: (context, index) => const CustomDivider(),
            itemCount: nutritions!.nutritions.length,
            itemBuilder: (context, index) {
              NutritionsOneMealModel nutritionsOneMeal = nutritions.nutritions.toList()[index];
              return NutritionResume(
                nutritions: nutritionsOneMeal,
                ondeDeleteCallback: (mealType, nutrition) =>
                    userStore.unregisterNutrition(widget.date, mealType, nutrition),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _noNutritionsWidget() {
    return Container(
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
    );
  }
}
