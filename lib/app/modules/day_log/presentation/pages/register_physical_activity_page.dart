import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:nutrilog/app/core/components/fields/search_field.dart';
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/list_physical_activities_model.dart';
import 'package:nutrilog/app/core/stores/get_physical_activities_store.dart';
import 'package:nutrilog/app/core/stores/states/get_physical_activity_states.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/modules/day_log/presentation/components/list_physical_activities_details.dart';

class RegisterPhysicalActivityPage extends StatefulWidget {
  final DateTime date;

  const RegisterPhysicalActivityPage({super.key, required this.date});

  @override
  State<RegisterPhysicalActivityPage> createState() => _RegisterPhysicalActivityPageState();
}

class _RegisterPhysicalActivityPageState extends State<RegisterPhysicalActivityPage> {
  final getPhysicalActivityStore = Modular.get<GetPhysicalActivityStore>();

  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: Left('Atividade Física')),
      body: Observer(builder: (context) {
        final state = getPhysicalActivityStore.state;

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

        getPhysicalActivityStore.onSearch(_textEditingController.text);
        List<ListPhysicalActivitiesModel> pA = getPhysicalActivityStore.afterSearch;

        return Container(
          color: CColors.primaryActivityWithOpacity,
          padding: const EdgeInsets.symmetric(
              horizontal: ScreenMargin.horizontal, vertical: ScreenMargin.vertical),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AdaptiveText(text: 'Selecione uma atividade física', textType: TextType.small),
              const SizedBox(height: 8),
              SearchField(
                onChanged: (v) => getPhysicalActivityStore.onSearch(v),
                controller: _textEditingController,
                iconColor: CColors.primaryActivity,
                hintText: 'Buscar atividade',
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemCount: pA.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 48),
                      child: ListPhysicalActivitiesWidget(list: pA[index]),
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
}
