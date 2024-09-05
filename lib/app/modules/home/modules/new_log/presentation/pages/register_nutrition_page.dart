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
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/formatters/formatters.dart';
import 'package:nutrilog/app/core/utils/show_bottom_sheet.dart';
import 'package:nutrilog/app/modules/home/modules/new_log/presentation/components/bottom_sheet/nutrition_energy_bottom_sheet.dart';
import 'package:nutrilog/app/modules/home/modules/new_log/presentation/components/bottom_sheet/nutrition_meal_type_bottom_sheet.dart';
import 'package:nutrilog/app/modules/home/modules/new_log/presentation/components/details/list_nutritions_details.dart';
import 'package:nutrilog/app/modules/home/modules/new_log/presentation/stores/new_log_store.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/manage_general_nutritions_store.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/states/user_history_states.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/user_history_store.dart';

class RegisterNutritionPage extends StatefulWidget {
  final DateTime date;

  const RegisterNutritionPage({super.key, required this.date});

  @override
  State<RegisterNutritionPage> createState() => _RegisterNutritionPageState();
}

class _RegisterNutritionPageState extends State<RegisterNutritionPage> {
  final userHistoryStore = Modular.get<UserHistoryStore>();
  final manageGeneralNutritionsStore = Modular.get<ManageGeneralNutritionsStore>();
  final newLogStore = Modular.get<NewLogStore>();

  final _onSearchTextController = TextEditingController();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    reactions = [
      reaction((_) => userHistoryStore.manageNutritionState, (ManageNutritionState state) {
        if (state is ManageNutritionSuccessState) {
          userHistoryStore.getHistory();
          Modular.to.popUntil(ModalRoute.withName('entry/home/'));
        } else if (state is ManageNutritionErrorState) {
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
        margin: const EdgeInsets.symmetric(horizontal: DefaultMargin.horizontal),
        child: Observer(builder: (context) {
          return CustomButton.primaryNutritionMedium(ButtonParameters(
            text: 'OK',
            isDisabled: manageGeneralNutritionsStore.nutritions.isEmpty,
            isLoading: userHistoryStore.manageNutritionState is ManageNutritionLoadingState,
            onTap: onTapOkCallback,
          ));
        }),
      ),
      body: Observer(builder: (context) {
        // manageGeneralNutritionsStore.onSearch(_onSearchTextController.text);
        List<ListNutritionsModel> nutritions = manageGeneralNutritionsStore.nutritions;

        return Container(
          color: CColors.primaryNutritionWithOpacity,
          padding: const EdgeInsets.symmetric(
              horizontal: DefaultMargin.horizontal, vertical: DefaultMargin.vertical),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AdaptiveText(text: 'Selecione um alimento', textType: TextType.small),
              const SizedBox(height: 8),
              CommonField(
                onChange: (_) =>
                    manageGeneralNutritionsStore.onSearch(_onSearchTextController.text),
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
              // if (manageGeneralNutritionsStore.nutritions.isNotEmpty)
              //   NutritionTag(
              //     nutritions:
              //         manageGeneralNutritionsStore.nutritions.map((n) => n.nutrition).toList() ??
              //             [],
              //     onDeleteCallback: (deleted) {
              //       List<NutritionWithEnergyModel> aux = List.from(dayLogStore.nutritions ?? []);
              //       aux.removeWhere((n) => n.nutrition == deleted);
              //       dayLogStore.nutritions = aux;
              //     },
              //   ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: nutritions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 48),
                      child: ListNutritionsWidget(
                        list: nutritions[index],
                        initalSelected: newLogStore.nutritions?.map((n) => n.nutrition).toList(),
                        onSelect: (values) {
                          setState(() {
                            final list = values
                                .map((s) => NutritionWithEnergyModel(
                                      nutrition:
                                          NutritionModel(name: s, type: nutritions[index].type),
                                    ))
                                .toList();
                            newLogStore.nutritions = List.from(list);
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
          initialMealValue: newLogStore.mealType ?? MealType.breakfast,
          initialTimeValue: TimeOfDay.now(),
          onOkCallback: (mealType, time) {
            newLogStore.mealType = mealType;
            newLogStore.time = time;

            Modular.to.pop();
            showCustomBottomSheet(
              context: context,
              builder: (context) {
                return NutritionEnergyBottomSheet(
                  totalEnergy: newLogStore.energy,
                  nutrition: newLogStore.nutritions!.first,
                  onOkCallback: (newNutrition, energy) {
                    newLogStore.energy = energy;
                    // newLogStore.nutritions = newNutrition;
                    newLogStore.registerNutrition(widget.date);

                    // Modular.to.pop();
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    for (var r in reactions) {
      r.reaction.dispose();
    }
    super.dispose();
  }
}
