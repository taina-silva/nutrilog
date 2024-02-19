import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/components/buttons/custom_button.dart';
import 'package:nutrilog/app/core/components/fields/common_field.dart';
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/components/toasts/toasts.dart';
import 'package:nutrilog/app/core/infra/enums/meal_type.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/list_nutritions_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_with_energy_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutritions_one_meal_model.dart';
import 'package:nutrilog/app/core/stores/get_nutrition_store.dart';
import 'package:nutrilog/app/core/stores/states/get_nutrition_states.dart';
import 'package:nutrilog/app/core/stores/states/user_states.dart';
import 'package:nutrilog/app/core/stores/user_store.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/formatters/formatters.dart';
import 'package:nutrilog/app/core/utils/show_bottom_sheet.dart';
import 'package:nutrilog/app/modules/day_log/presentation/components/bottom_sheet/nutrition_energy_bottom_sheet.dart';
import 'package:nutrilog/app/modules/day_log/presentation/components/bottom_sheet/nutrition_meal_type_bottom_sheet.dart';
import 'package:nutrilog/app/modules/day_log/presentation/components/details/list_nutritions_details.dart';
import 'package:nutrilog/app/modules/day_log/presentation/components/details/nutrition_tag.dart';
import 'package:nutrilog/app/modules/day_log/presentation/stores/day_log_store.dart';

class RegisterNutritionPage extends StatefulWidget {
  final DateTime date;

  const RegisterNutritionPage({super.key, required this.date});

  @override
  State<RegisterNutritionPage> createState() => _RegisterNutritionPageState();
}

class _RegisterNutritionPageState extends State<RegisterNutritionPage> {
  final getNutritionStore = Modular.get<GetNutritionStore>();
  final dayLogStore = Modular.get<DayLogStore>();
  final userStore = Modular.get<UserStore>();

  final _onSearchTextController = TextEditingController();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    reactions = [
      reaction((_) => userStore.registerNutritionState, (RegisterNutritionState state) {
        if (state is RegisterNutritionSuccessState) {
          Modular.to.pop();
        } else if (state is RegisterNutritionErrorState) {
          errorToast(context, state.message);
        }
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: Left(formatDate(widget.date))),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: ScreenMargin.horizontal),
        child: Observer(builder: (context) {
          return CustomButton.primaryNutritionMedium(ButtonParameters(
            text: 'OK',
            isDisabled: dayLogStore.nutritions?.isEmpty ?? true,
            isLoading: userStore.registerNutritionState is RegisterNutritionLoadingState,
            onTap: onTapOkCallback,
          ));
        }),
      ),
      body: Observer(builder: (context) {
        final state = getNutritionStore.state;

        if (state is GetNutritionInitialState) {
          return const SizedBox();
        }

        if (state is GetNutritionLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetNutritionErrorState) {
          return Center(
              child: AdaptiveText(
            text: state.message,
            textType: TextType.medium,
            textAlign: TextAlign.center,
          ));
        }

        getNutritionStore.onSearch(_onSearchTextController.text);
        List<ListNutritionsModel> n = getNutritionStore.afterSearch;

        return Container(
          color: CColors.primaryNutritionWithOpacity,
          padding: const EdgeInsets.symmetric(
              horizontal: ScreenMargin.horizontal, vertical: ScreenMargin.vertical),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AdaptiveText(text: 'Selecione um alimento', textType: TextType.small),
              const SizedBox(height: 8),
              CommonField(
                onChange: (_) => getNutritionStore.onSearch(_onSearchTextController.text),
                controller: _onSearchTextController,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                fillColor: Colors.white,
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (_onSearchTextController.text.isNotEmpty) _onSearchTextController.clear();
                  },
                  child: Icon(_onSearchTextController.text.isEmpty ? Icons.search : Icons.close,
                      color: CColors.primaryNutrition),
                ),
                placeholder: 'Buscar alimento',
              ),
              const SizedBox(height: 16),
              if (dayLogStore.nutritions?.isNotEmpty ?? false)
                NutritionTag(
                  nutritions: dayLogStore.nutritions?.map((n) => n.nutrition).toList() ?? [],
                  onDeleteCallback: (deleted) {
                    List<NutritionWithEnergyModel> aux = List.from(dayLogStore.nutritions ?? []);
                    aux.removeWhere((n) => n.nutrition == deleted);
                    dayLogStore.nutritions = aux;
                  },
                ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: n.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 48),
                      child: ListNutritionsWidget(
                        list: n[index],
                        initalSelected: dayLogStore.nutritions?.map((n) => n.nutrition).toList(),
                        onSelect: (p) {
                          setState(() {
                            List<NutritionWithEnergyModel> aux = [];

                            for (String s in p) {
                              aux.add(NutritionWithEnergyModel(
                                  nutrition: NutritionModel(type: n[index].type, name: s),
                                  energy: 0));
                            }

                            dayLogStore.nutritions = aux;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void onTapOkCallback() {
    showCustomBottomSheet(
      context: context,
      builder: (context) {
        return NutritionMealTypeBottomSheet(
          initialMealValue: dayLogStore.mealType ?? MealType.breakfast,
          initialTimeValue: dayLogStore.timeOfDay,
          onOkCallback: (mealType, time) {
            dayLogStore.mealType = mealType;
            dayLogStore.timeOfDay = time;

            Modular.to.pop();

            showCustomBottomSheet(
              context: context,
              builder: (context) {
                return NutritionEnergyBottomSheet(
                  totalEnergy: dayLogStore.energy,
                  nutritions: dayLogStore.nutritions ?? [],
                  onOkCallback: (newNutritions, energy) {
                    dayLogStore.energy = energy;
                    dayLogStore.nutritions = newNutritions;

                    userStore.registerNutrition(
                      DateTime.now(),
                      NutritionsOneMealModel(
                        energy: dayLogStore.energy ?? 0,
                        mealType: dayLogStore.mealType ?? MealType.breakfast,
                        timeOfDay: dayLogStore.timeOfDay ?? TimeOfDay.now(),
                        nutritions: dayLogStore.nutritions ?? [],
                      ),
                    );

                    Modular.to.pop();
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
