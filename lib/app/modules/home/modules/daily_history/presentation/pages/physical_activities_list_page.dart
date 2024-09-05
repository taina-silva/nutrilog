import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/components/toasts/toasts.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/formatters/formatters.dart';
import 'package:nutrilog/app/modules/home/modules/daily_history/presentation/components/physical_activity_resume.dart';
import 'package:nutrilog/app/modules/home/modules/daily_history/presentation/stores/daily_history_store.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/states/user_history_states.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/user_history_store.dart';

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
  final userHistoryStore = Modular.get<UserHistoryStore>();
  final dailyHistoryStore = Modular.get<DailyHistoryStore>();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    dailyHistoryStore.getNutritions(widget.date);

    reactions = [
      reaction((_) => userHistoryStore.managePhysicalActivityState,
          (ManagePhysicalActivityState state) async {
        if (state is ManagePhysicalActivityErrorState) {
          errorToast(context, 'Falha ao deletar atividade física: ${state.message}');
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
          if (dailyHistoryStore.physicalActivities.isEmpty) {
            return _noPhysicalActivitiesWidget();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: dailyHistoryStore.physicalActivities.length,
            itemBuilder: (context, index) {
              return PhysicalActivityResume(
                pA: dailyHistoryStore.physicalActivities[index],
                onDeleteCallback: (pA) =>
                    userHistoryStore.unregisterPhysicalActivity(widget.date, pA),
                isBeingDeleted: (pA) {
                  return false;
                },
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
