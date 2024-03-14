import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/components/toasts/toasts.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/stores/states/user_states.dart';
import 'package:nutrilog/app/core/stores/user_store.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/formatters/formatters.dart';
import 'package:nutrilog/app/modules/physical_activities/presentation/components/physical_activity_resume.dart';

class PhysicalActivitiesListPage extends StatefulWidget {
  final DateTime date;
  final List<PhysicalActivityWithDurationModel> physicalActivities;

  const PhysicalActivitiesListPage({
    Key? key,
    required this.date,
    required this.physicalActivities,
  }) : super(key: key);

  @override
  State<PhysicalActivitiesListPage> createState() => _PhysicalActivitiesListPageState();
}

class _PhysicalActivitiesListPageState extends State<PhysicalActivitiesListPage> {
  final userStore = Modular.get<UserStore>();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    reactions = [
      reaction((_) => userStore.unregisterPhysicalActitityState,
          (UnregisterPhysicalActivityState state) async {
        if (state is UnregisterPhysicalActivityErrorState) {
          errorToast(context, 'Falha ao deletar atividade: ${state.message}');
        } else if (state is UnregisterPhysicalActivitySuccessState) {
          userStore.getUserDayLog();
        }
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.physicalActivities.isEmpty) {
      return CustomScaffold(
        appBar: const CustomAppBar(title: Left('Atividades físicas')),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: DefaultMargin.horizontal,
            vertical: DefaultMargin.vertical,
          ),
          alignment: Alignment.center,
          child: AdaptiveText(
            text: 'Sem atividades físicas registradas para o dia ${formatDate(widget.date)}',
            textType: TextType.medium,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return CustomScaffold(
      appBar: const CustomAppBar(title: Left('Atividades Físicas')),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 8, right: 8),
            decoration: const BoxDecoration(
                color: CColors.primaryActivity,
                borderRadius: BorderRadius.all(Radius.circular(Layout.borderRadiusBig))),
            child: const Icon(Icons.add_outlined, color: CColors.neutral0),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: DefaultMargin.horizontal,
          vertical: DefaultMargin.vertical,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: widget.physicalActivities.length,
          itemBuilder: (context, index) {
            PhysicalActivityWithDurationModel pA = widget.physicalActivities[index];
            return PhysicalActivityResume(
              pA: pA,
              onDeleteCallback: (pA) => userStore.unregisterPhysicalActivity(widget.date, pA),
            );
          },
        ),
      ),
    );
  }
}
