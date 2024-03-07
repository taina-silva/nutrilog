import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/duration.dart';

class PhysicalActivityResume extends StatelessWidget {
  final PhysicalActivityWithDurationModel pA;

  const PhysicalActivityResume({
    Key? key,
    required this.pA,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(DefaultPadding.nano),
          margin: const EdgeInsets.only(
            bottom: DefaultPadding.normal,
            right: DefaultPadding.nano,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: CColors.primaryActivity, width: Layout.borderWidth),
            borderRadius: const BorderRadius.all(Radius.circular(Layout.borderRadiusSmall)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdaptiveText(
                text: pA.physicalActivity.name,
                textType: TextType.medium,
                fWeight: FWeight.bold,
              ),
              const SizedBox(height: 8),
              AdaptiveText(
                text: 'Duração: ${durationToString(pA.duration)}',
                textType: TextType.small,
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(DefaultPadding.nano),
            decoration: const BoxDecoration(
              color: CColors.primaryActivity,
              borderRadius: BorderRadius.all(Radius.circular(Layout.borderRadiusBig)),
            ),
            child: const Icon(Icons.edit_outlined, color: CColors.neutral0),
          ),
        ),
      ],
    );
  }
}
