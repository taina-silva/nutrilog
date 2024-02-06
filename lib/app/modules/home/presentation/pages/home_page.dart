import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/components/buttons/custom_button.dart';
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/toasts/toasts.dart';
import 'package:nutrilog/app/core/stores/auth_store.dart';
import 'package:nutrilog/app/core/stores/states/auth_states.dart';
import 'package:nutrilog/app/core/stores/user_store.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/show_date_picker.dart';
import 'package:nutrilog/app/modules/nutrition/presentation/stores/nutritions_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authStore = Modular.get<AuthStore>();
  final userStore = Modular.get<UserStore>();
  final nutritionsStore = Modular.get<NutritionsStore>();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

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
            horizontal: ScreenMargin.horizontal, vertical: ScreenMargin.vertical),
        child: Column(
          children: [
            CustomButton.secondaryActivityMedium(ButtonParameters(
              text: 'Atividade física',
              prefixIcon: Icons.add_outlined,
              onTap: () {
                showCustomDatePicker(context: context, initialDate: DateTime.now());

                // Modular.to.pushNamed('physical-activity', forRoot: true);
              },
            )),
            const SizedBox(height: 8),
            CustomButton.secondaryNutritionMedium(
                const ButtonParameters(text: 'Alimentação', prefixIcon: Icons.add_outlined)),
          ],
        ),
      ),
    );
  }
}
