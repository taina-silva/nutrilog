import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/core/components/buttons/custom_button.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/utils/constants.dart';

class PhysicalActivityDurationBottomSheet extends StatelessWidget {
  final void Function(Duration) onOkCallback;

  const PhysicalActivityDurationBottomSheet({super.key, required this.onOkCallback});

  @override
  Widget build(BuildContext context) {
    Duration? duration;

    return Container(
      height: 400,
      margin: const EdgeInsets.symmetric(
          horizontal: DefaultMargin.horizontal, vertical: DefaultMargin.vertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AdaptiveText(
            text: 'Informe a duração da atividade física selecionada',
            textType: TextType.small,
          ),
          const SizedBox(height: 32),
          CupertinoTimerPicker(onTimerDurationChanged: (d) => duration = d),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton.secondaryNeutroSmall(
                ButtonParameters(
                  text: 'VOLTAR',
                  width: (MediaQuery.of(context).size.width - 2 * DefaultMargin.horizontal) * 0.45,
                  onTap: () => Modular.to.pop(),
                ),
              ),
              CustomButton.primaryNeutroSmall(
                ButtonParameters(
                  text: 'OK',
                  width: (MediaQuery.of(context).size.width - 2 * DefaultMargin.horizontal) * 0.45,
                  onTap: () {
                    if (duration != null) onOkCallback(duration!);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
