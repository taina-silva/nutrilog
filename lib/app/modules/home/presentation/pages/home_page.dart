import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/toasts/toasts.dart';
import 'package:nutrilog/app/core/stores/auth_store.dart';
import 'package:nutrilog/app/core/stores/states/auth_states.dart';
import 'package:nutrilog/app/core/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authStore = Modular.get<AuthStore>();

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
    );
  }
}
