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
import 'package:nutrilog/app/core/infra/models/day_log_model.dart';
import 'package:nutrilog/app/core/stores/auth_store.dart';
import 'package:nutrilog/app/core/stores/get_nutrition_store.dart';
import 'package:nutrilog/app/core/stores/states/auth_states.dart';
import 'package:nutrilog/app/core/stores/states/user_states.dart';
import 'package:nutrilog/app/core/stores/user_store.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/show_date_picker.dart';
import 'package:nutrilog/app/modules/home/presentation/components/day_log_resume.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authStore = Modular.get<AuthStore>();
  final userStore = Modular.get<UserStore>();
  final nutritionsStore = Modular.get<GetNutritionStore>();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    userStore.getUserDayLog();

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
      body: Observer(builder: (context) {
        if (userStore.getUserDayLogState is GetUserDayLogInitialState) {
          return const SizedBox();
        }

        if (userStore.getUserDayLogState is GetUserDayLogLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userStore.getUserDayLogState is GetUserDayLogErrorState) {
          return Center(
              child: AdaptiveText(
            text: (userStore.getUserDayLogState as GetUserDayLogErrorState).message,
            textType: TextType.medium,
          ));
        }

        return Container(
          margin: const EdgeInsets.symmetric(
              horizontal: ScreenMargin.horizontal, vertical: ScreenMargin.vertical),
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
              Expanded(
                child: Builder(builder: (context) {
                  List<DayLogModel> dayLog =
                      (userStore.getUserDayLogState as GetUserDayLogSuccessState).list;

                  if (dayLog.isEmpty) {
                    return const Center(
                      child: AdaptiveText(
                          text: 'Nenhum registro até o momento', textType: TextType.small),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: dayLog.length,
                    itemBuilder: (context, index) {
                      return DayLogResume(dayLog: dayLog[index]);
                    },
                  );
                }),
              )
            ],
          ),
        );
      }),
    );
  }

  Future<void> onTapRegister(String path) async {
    DateTime? date = await showCustomDatePicker(context: context, initialDate: DateTime.now());
    if (date == null) return;

    Modular.to.pushNamed(
      'day-log/$path',
      arguments: {'date': date},
      forRoot: true,
    );
  }
}
