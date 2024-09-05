import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/components/buttons/custom_button.dart';
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/components/toasts/toasts.dart';
import 'package:nutrilog/app/core/infra/models/day_log/day_log_model.dart';
import 'package:nutrilog/app/core/stores/auth_store.dart';
import 'package:nutrilog/app/core/stores/states/auth_states.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/show_date_picker.dart';
import 'package:nutrilog/app/modules/home/presentation/components/day_log_resume.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/manage_general_nutritions_store.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/manage_general_physical_activities_store.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/states/user_history_states.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/user_history_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authStore = Modular.get<AuthStore>();
  final userHistoryStore = Modular.get<UserHistoryStore>();
  final manageGeneralPhysicalActivitiesStore = Modular.get<ManageGeneralPhysicalActivitiesStore>();
  final manageGeneralNutritionsStore = Modular.get<ManageGeneralNutritionsStore>();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    userHistoryStore.getHistory();
    manageGeneralPhysicalActivitiesStore.getGeneralPhysicalActivities();
    manageGeneralNutritionsStore.getGeneralNutritions();

    reactions = [
      reaction((_) => authStore.signoutState, (SignoutState state) async {
        if (state is SignoutErrorState) {
          errorToast(context, state.message);
        } else if (state is SignoutSuccessState) {
          Modular.to.navigate('/access/');
        }
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: Right(Padding(
          padding: const EdgeInsets.symmetric(vertical: DefaultPadding.nano),
          child: Image.asset(Assets.logo),
        )),
        trailing: [
          GestureDetector(
            onTap: () => authStore.signout(),
            child: const Icon(Icons.logout_outlined, size: 40),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: DefaultMargin.horizontal, vertical: DefaultMargin.vertical),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomButton.secondaryActivityMedium(ButtonParameters(
              text: 'Atividade física',
              prefixIcon: Icons.add_outlined,
              onTap: () async => onTapRegister('physical-activity'),
            )),
            const SizedBox(height: 8),
            CustomButton.secondaryNutritionMedium(ButtonParameters(
              text: 'Alimentação',
              prefixIcon: Icons.add_outlined,
              onTap: () async => onTapRegister('nutrition'),
            )),
            const SizedBox(height: 24),
            const AdaptiveText(text: 'Histórico', textType: TextType.medium),
            const SizedBox(height: 24),
            Observer(builder: (context) {
              if (userHistoryStore.getHistoryState is GetHistoryInitialState) {
                return const SizedBox();
              }

              if (userHistoryStore.getHistoryState is GetHistoryLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (userHistoryStore.getHistoryState is GetHistoryErrorState) {
                return Center(
                    child: AdaptiveText(
                  text: (userHistoryStore.getHistoryState as GetHistoryErrorState).message,
                  textType: TextType.medium,
                ));
              }

              List<DayLogModel> dayLog =
                  (userHistoryStore.getHistoryState as GetHistorySuccessState).list;

              if (dayLog.isEmpty) {
                return Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: DefaultMargin.vertical),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("${Assets.gifs}/not_found.gif"),
                        const AdaptiveText(
                            text: 'Nenhum registro até o momento.', textType: TextType.small),
                      ],
                    ),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: dayLog.length,
                  itemBuilder: (context, index) {
                    return DayLogResume(dayLog: dayLog[index]);
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Future<void> onTapRegister(String path) async {
    DateTime? date = await showCustomDatePicker(context: context, initialDate: DateTime.now());
    if (date == null) return;

    Modular.to.pushNamed(
      'new-log/$path',
      arguments: {'date': date},
      forRoot: true,
    );
  }
}
