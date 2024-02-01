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
import 'package:nutrilog/app/core/infra/models/register_physical_activity_payload_model.dart';
import 'package:nutrilog/app/core/stores/auth_store.dart';
import 'package:nutrilog/app/core/stores/states/auth_states.dart';
import 'package:nutrilog/app/core/stores/user_store.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/date_extension.dart';
import 'package:nutrilog/app/modules/physical_activities/infra/models/physical_activity_model.dart';
import 'package:nutrilog/app/modules/physical_activities/stores/physical_activities_store.dart';
import 'package:nutrilog/app/modules/physical_activities/stores/states/physical_activities_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authStore = Modular.get<AuthStore>();
  final userStore = Modular.get<UserStore>();
  final physicalActivitiesStore = Modular.get<PhysicalActivitiesStore>();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    userStore.registerPhysicalActivity(
      DateTime.now().datetimeWithTimeReset(),
      const RegisterPhysicalActivityPayloadModel(
        duration: Duration(hours: 1),
        physicalActivity: PhysicalActivityModel(
          name: 'corrida',
          activityType: 'aeróbico',
        ),
      ),
    );
    /*    physicalActivitiesStore.getAllPhysicalActivities(); */

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
        final state = physicalActivitiesStore.state;

        if (state is GetPhysicalActivitiesInitialState) {
          return const SizedBox();
        }

        if (state is GetPhysicalActivitiesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetPhysicalActivitiesErrorState) {
          return Center(child: AdaptiveText(text: state.message, textType: TextType.medium));
        }

        List<PhysicalActivityModel> list =
            (state as GetPhysicalActivitiesSuccessState).physicalActivities;

        if (list.isEmpty) {
          return CustomButton.secondaryNeutroMedium(
              const ButtonParameters(text: 'Adicionar registro'));
        }

        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return AdaptiveText(text: list[index].name, textType: TextType.small);
          },
        );
      }),
    );
  }
}
