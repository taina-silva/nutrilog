import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/components/toasts/toasts.dart';
import 'package:nutrilog/app/core/infra/models/day_log/day_log_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/stores/states/user_states.dart';
import 'package:nutrilog/app/core/stores/user_store.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/formatters/formatters.dart';
import 'package:nutrilog/app/modules/physical_activities/presentation/components/physical_activity_resume.dart';

class PhysicalActivitiesListPage extends StatefulWidget {
  final DateTime date;

  const PhysicalActivitiesListPage({
    Key? key,
    required this.date,
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
            child: InkWell(
              onTap: () {
                Modular.to.pushNamed(
                  'day-log/physical-activity',
                  forRoot: true,
                  arguments: {'date': widget.date},
                );
              },
              child: const Icon(Icons.add_outlined, color: CColors.neutral0),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: DefaultMargin.horizontal,
          vertical: DefaultMargin.vertical,
        ),
        child: Observer(builder: (context) {
          if (userStore.getUserDayLogState is GetUserDayLogInitialState) return const SizedBox();

          if (userStore.getUserDayLogState is GetUserDayLogLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userStore.getUserDayLogState is GetUserDayLogErrorState) {
            return _noPhysicalActivitiesWidget();
          }

          List<DayLogModel> dayLogs =
              (userStore.getUserDayLogState as GetUserDayLogSuccessState).list;
          DayLogModel? dayLog = dayLogs.firstWhereOrNull((e) => e.date == widget.date);
          List<PhysicalActivityWithDurationModel> physicalActivities =
              dayLog?.physicalActivities ?? [];

          if (physicalActivities.isEmpty) return _noPhysicalActivitiesWidget();

          return ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: physicalActivities.length,
            itemBuilder: (context, index) {
              PhysicalActivityWithDurationModel pA = physicalActivities[index];
              return PhysicalActivityResume(
                pA: pA,
                onDeleteCallback: (pA) => userStore.unregisterPhysicalActivity(widget.date, pA),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _noPhysicalActivitiesWidget() {
    return Container(
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
    );
  }
}
