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
import 'package:nutrilog/app/core/stores/get_physical_activities_store.dart';
import 'package:nutrilog/app/core/stores/states/get_physical_activity_states.dart';
import 'package:nutrilog/app/core/stores/states/user_states.dart';
import 'package:nutrilog/app/core/stores/user_store.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/formatters/formatters.dart';
import 'package:nutrilog/app/core/utils/show_bottom_sheet.dart';
import 'package:nutrilog/app/modules/day_log/presentation/components/bottom_sheet/physical_activity_duration_bottom_sheet.dart';
import 'package:nutrilog/app/modules/day_log/presentation/components/details/list_physical_activities_details.dart';
import 'package:nutrilog/app/modules/day_log/presentation/stores/day_log_store.dart';

class RegisterPhysicalActivityPage extends StatefulWidget {
  final DateTime date;

  const RegisterPhysicalActivityPage({super.key, required this.date});

  @override
  State<RegisterPhysicalActivityPage> createState() => _RegisterPhysicalActivityPageState();
}

class _RegisterPhysicalActivityPageState extends State<RegisterPhysicalActivityPage> {
  final getPhysicalActivityStore = Modular.get<GetPhysicalActivityStore>();
  final dayLogStore = Modular.get<DayLogStore>();
  final userStore = Modular.get<UserStore>();

  final _textEditingController = TextEditingController();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    reactions = [
      reaction((_) => userStore.registerPhysicalActitityState,
          (RegisterPhysicalActivityState state) {
        if (state is RegisterPhysicalActivitySuccessState) {
          userStore.getUserDayLog();
          Modular.to.popUntil(ModalRoute.withName('entry/home/'));
        } else if (state is RegisterPhysicalActivityErrorState) {
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
            isDisabled: dayLogStore.physicalActivity == null,
            isLoading:
                userStore.registerPhysicalActitityState is RegisterPhysicalActivityLoadingState,
            onTap: () {
              showCustomBottomSheet(
                context: context,
                builder: (context) {
                  return PhysicalActivityDurationBottomSheet(
                    onOkCallback: (duration) {
                      Modular.to.pop();
                      userStore.registerPhysicalActivity(
                        widget.date,
                        PhysicalActivityWithDurationModel(
                            physicalActivity: dayLogStore.physicalActivity!, duration: duration),
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
              horizontal: DefaultMargin.horizontal, vertical: DefaultMargin.vertical),
          margin: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AdaptiveText(text: 'Selecione uma atividade física', textType: TextType.small),
              const SizedBox(height: 8),
              CommonField(
                onChange: (_) => getPhysicalActivityStore.onSearch(_textEditingController.text),
                controller: _textEditingController,
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
                  padding: const EdgeInsets.all(0),
                  itemCount: pA.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 48),
                      child: ListPhysicalActivitiesWidget(
                        list: pA[index],
                        initalSelected: dayLogStore.physicalActivity,
                        onSelect: (p) {
                          setState(() {
                            PhysicalActivityModel aux =
                                PhysicalActivityModel(type: pA[index].type, name: p);

                            dayLogStore.physicalActivity =
                                aux == dayLogStore.physicalActivity ? null : aux;
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
}
