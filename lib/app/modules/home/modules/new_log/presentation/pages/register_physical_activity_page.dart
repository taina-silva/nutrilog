import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:mobx/mobx.dart';
import 'package:nutrilog/app/core/components/buttons/custom_button.dart';
import 'package:nutrilog/app/core/components/fields/common_field.dart';
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/components/toasts/toasts.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/list_physical_activities_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/formatters/formatters.dart';
import 'package:nutrilog/app/core/utils/show_bottom_sheet.dart';
import 'package:nutrilog/app/modules/home/modules/new_log/presentation/components/bottom_sheet/physical_activity_duration_bottom_sheet.dart';
import 'package:nutrilog/app/modules/home/modules/new_log/presentation/components/details/list_physical_activities_details.dart';
import 'package:nutrilog/app/modules/home/modules/new_log/presentation/stores/new_log_store.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/manage_general_physical_activities_store.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/states/user_history_states.dart';
import 'package:nutrilog/app/modules/home/presentation/stores/user_history_store.dart';

class RegisterPhysicalActivityPage extends StatefulWidget {
  final DateTime date;

  const RegisterPhysicalActivityPage({super.key, required this.date});

  @override
  State<RegisterPhysicalActivityPage> createState() => _RegisterPhysicalActivityPageState();
}

class _RegisterPhysicalActivityPageState extends State<RegisterPhysicalActivityPage> {
  final userHistoryStore = Modular.get<UserHistoryStore>();
  final pAStore = Modular.get<ManageGeneralPhysicalActivitiesStore>();
  final newLogStore = Modular.get<NewLogStore>();

  final _textEditingController = TextEditingController();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    pAStore.onSearch(_textEditingController.text);
    _textEditingController.addListener(() {
      pAStore.onSearch(_textEditingController.text);
    });

    reactions = [
      reaction((_) => userHistoryStore.managePhysicalActivityState,
          (ManagePhysicalActivityState state) {
        if (state is ManagePhysicalActivitySuccessState) {
          userHistoryStore.getHistory();
          Modular.to.popUntil(ModalRoute.withName('entry/home/'));
        } else if (state is ManagePhysicalActivityErrorState) {
          errorToast(context, state.message);
        }
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: Left(formatDate(widget.date))),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: DefaultMargin.horizontal),
        child: Observer(builder: (context) {
          return CustomButton.primaryActivityMedium(ButtonParameters(
            text: 'OK',
            isDisabled: newLogStore.physicalActivity == null,
            isLoading:
                userHistoryStore.managePhysicalActivityState is ManagePhysicalActivityLoadingState,
            onTap: () {
              showCustomBottomSheet(
                context: context,
                builder: (context) {
                  return PhysicalActivityDurationBottomSheet(
                    onOkCallback: (duration) {
                      Modular.to.pop();
                      userHistoryStore.registerPhysicalActivity(
                        widget.date,
                        PhysicalActivityWithDurationModel(
                            physicalActivity: newLogStore.physicalActivity!, duration: duration),
                      );
                    },
                  );
                },
              );
            },
          ));
        }),
      ),
      body: Observer(builder: (context) {
        List<ListPhysicalActivitiesModel> physicalActivites = pAStore.afterSearch;

        return Container(
          color: CColors.primaryActivityWithOpacity,
          padding: const EdgeInsets.symmetric(
              horizontal: DefaultMargin.horizontal, vertical: DefaultMargin.vertical),
          margin: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AdaptiveText(text: 'Selecione uma atividade física', textType: TextType.small),
              const SizedBox(height: 8),
              CommonField(
                controller: _textEditingController,
                onChange: (_) => pAStore.onSearch(_textEditingController.text),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                fillColor: Colors.white,
                suffixIcon: GestureDetector(
                  onTap: () {
                    if (_textEditingController.text.isNotEmpty) _textEditingController.clear();
                  },
                  child: Icon(_textEditingController.text.isEmpty ? Icons.search : Icons.close,
                      color: CColors.primaryActivity),
                ),
                placeholder: 'Buscar atividade',
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: physicalActivites.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 48),
                      child: ListPhysicalActivitiesWidget(
                        list: physicalActivites[index],
                        initalSelected: newLogStore.physicalActivity,
                        onSelect: (p) {
                          setState(() {
                            PhysicalActivityModel pA =
                                PhysicalActivityModel(type: physicalActivites[index].type, name: p);
                            newLogStore.physicalActivity =
                                pA == newLogStore.physicalActivity ? null : pA;
                          });
                        },
                      ),
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

  @override
  void dispose() {
    for (var r in reactions) {
      r.reaction.dispose();
    }
    super.dispose();
  }
}
