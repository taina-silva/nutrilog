import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/list_nutritions_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

class ListNutritionsWidget extends StatefulWidget {
  final ListNutritionsModel list;
  final NutritionModel? initalSelected;
  final void Function(String) onSelect;

  const ListNutritionsWidget({
    super.key,
    required this.list,
    required this.initalSelected,
    required this.onSelect,
  });

  @override
  State<ListNutritionsWidget> createState() => _ListNutritionsWidgetState();
}

class _ListNutritionsWidgetState extends State<ListNutritionsWidget> {
  late String selected;

  @override
  void initState() {
    super.initState();

    selected = widget.initalSelected?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdaptiveText(
          text: widget.list.type,
          textType: TextType.medium,
          fWeight: FWeight.bold,
        ),
        const SizedBox(height: 8),
        Wrap(
          runAlignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: widget.list.list.map((n) {
            return GestureDetector(
              onTap: () {
                setState(() => selected = n);
                widget.onSelect(n);
              },
              child: Container(
                padding: const EdgeInsets.all(DefaultPadding.nano),
                decoration: BoxDecoration(
                  color: n == selected && widget.initalSelected?.type == widget.list.type
                      ? CColors.primaryNutrition
                      : CColors.neutral0,
                  border: Border.all(color: CColors.primaryNutrition, width: Layout.borderWidth),
                  borderRadius: const BorderRadius.all(Radius.circular(Layout.borderRadiusMedium)),
                ),
                child: AdaptiveText(text: n, textType: TextType.small),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
