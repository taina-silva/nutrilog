import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:nutrilog/app/core/components/buttons/custom_button.dart';
import 'package:nutrilog/app/core/components/structure/custom_app_bar.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
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
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: Left('Atividades Físicas')),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DefaultMargin.horizontal,
        ),
        child: CustomButton.primaryActivityMedium(
          const ButtonParameters(text: 'Salvar alterações'),
        ),
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
            return PhysicalActivityResume(pA: pA);
          },
        ),
      ),
    );
  }
}
