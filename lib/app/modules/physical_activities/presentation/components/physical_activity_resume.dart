import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_with_duration_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/duration.dart';
import 'package:nutrilog/app/core/utils/string.dart';

class PhysicalActivityResume extends StatelessWidget {
  final PhysicalActivityWithDurationModel pA;
  final void Function(PhysicalActivityWithDurationModel) onDeleteCallback;

  const PhysicalActivityResume({
    Key? key,
    required this.pA,
    required this.onDeleteCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerHeight = 144;
    double iconContainerWidth = 72;
    double infoContainerWidth =
        MediaQuery.of(context).size.width - 2 * DefaultMargin.horizontal - 80;

    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: iconContainerWidth,
              height: containerHeight,
              padding: const EdgeInsets.all(DefaultPadding.nano),
              decoration: BoxDecoration(
                border: Border.all(color: CColors.primaryActivity, width: Layout.borderWidth),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Layout.borderRadiusSmall),
                  bottomLeft: Radius.circular(Layout.borderRadiusSmall),
                ),
              ),
              child: Image.asset(
                '${Assets.icons}/${removeAccentsFromStr(pA.physicalActivity.type)}.png',
                color: CColors.primaryActivity,
              ),
            ),
            Container(
              width: infoContainerWidth,
              height: containerHeight,
              padding: const EdgeInsets.all(DefaultPadding.nano),
              margin: const EdgeInsets.only(bottom: DefaultPadding.normal),
              decoration: const BoxDecoration(
                color: CColors.primaryActivity,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Layout.borderRadiusSmall),
                  bottomRight: Radius.circular(Layout.borderRadiusSmall),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            2 * DefaultMargin.horizontal -
                            iconContainerWidth -
                            2 * DefaultPadding.nano -
                            40,
                        child: AdaptiveText(
                          text: pA.physicalActivity.name,
                          textType: TextType.small,
                          color: CColors.neutral0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AdaptiveText(
                        text: durationToString(pA.duration),
                        textType: TextType.large,
                        fWeight: FWeight.bold,
                        color: CColors.neutral0,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: CColors.neutral0,
                            borderRadius:
                                BorderRadius.all(Radius.circular(Layout.borderRadiusBig))),
                        child: AdaptiveText(
                          text: pA.physicalActivity.type,
                          textType: TextType.nano,
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // const Icon(Icons.edit_outlined, color: CColors.neutral0, size: 32),
                      GestureDetector(
                        onTap: () => onDeleteCallback(pA),
                        child: const Icon(Icons.delete_outlined, color: CColors.neutral0, size: 32),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
