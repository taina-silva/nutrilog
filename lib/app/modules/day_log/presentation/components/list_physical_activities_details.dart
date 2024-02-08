import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/list_physical_activities_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

class ListPhysicalActivitiesWidget extends StatelessWidget {
  final ListPhysicalActivitiesModel list;

  const ListPhysicalActivitiesWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdaptiveText(
          text: list.type,
          textType: TextType.medium,
          fWeight: FWeight.bold,
        ),
        const SizedBox(height: 8),
        Wrap(
          runAlignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: list.list.map((p) {
            return Container(
              padding: const EdgeInsets.all(DefaultPadding.nano),
              decoration: BoxDecoration(
                color: CColors.neutral0,
                border: Border.all(color: CColors.primaryActivity, width: Layout.borderWidth),
                borderRadius: const BorderRadius.all(Radius.circular(Layout.borderRadiusMedium)),
              ),
              child: AdaptiveText(text: p, textType: TextType.small),
            );
          }).toList(),
        )
      ],
    );
  }
}
