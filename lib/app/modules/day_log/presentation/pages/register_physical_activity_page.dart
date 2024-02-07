import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/list_physical_activities_model.dart';
import 'package:nutrilog/app/core/stores/get_physical_activities_store.dart';
import 'package:nutrilog/app/core/stores/states/get_physical_activity_states.dart';
import 'package:nutrilog/app/core/utils/constants.dart';

class RegisterPhysicalActivityPage extends StatefulWidget {
  final DateTime date;

  const RegisterPhysicalActivityPage({super.key, required this.date});

  @override
  State<RegisterPhysicalActivityPage> createState() => _RegisterPhysicalActivityPageState();
}

class _RegisterPhysicalActivityPageState extends State<RegisterPhysicalActivityPage> {
  final physicalActivitiesStore = Modular.get<GetPhysicalActivityStore>();

  @override
  void initState() {
    super.initState();

    physicalActivitiesStore.getAllPhysicalActivities();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: Left('Atividade Física')),
      body: Observer(builder: (context) {
        final state = physicalActivitiesStore.state;

        if (state is GetPhysicalActivitiesInitialState) {
          return const SizedBox();
        }

        if (state is GetPhysicalActivitiesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetPhysicalActivitiesErrorState) {
          return Center(
              child: AdaptiveText(
            text: state.message,
            textType: TextType.medium,
            textAlign: TextAlign.center,
          ));
        }

        List<ListPhysicalActivitiesModel> list =
            (state as GetPhysicalActivitiesSuccessState).physicalActivities;

        return Container(
          margin: const EdgeInsets.symmetric(
              horizontal: ScreenMargin.horizontal, vertical: ScreenMargin.vertical),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: list.first.list.length,
                  itemBuilder: (context, index) {
                    return AdaptiveText(text: list.first.list[index], textType: TextType.small);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
