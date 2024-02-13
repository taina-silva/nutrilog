import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/list_nutritions_model.dart';
import 'package:nutrilog/app/core/infra/models/nutrition/nutrition_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

class ListNutritionsWidget extends StatefulWidget {
  final ListNutritionsModel list;
  final List<NutritionModel>? initalSelected;
  final void Function(List<String>) onSelect;

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
  late List<String> selected;

  @override
  Widget build(BuildContext context) {
    selected =
        widget.initalSelected == null ? [] : widget.initalSelected!.map((e) => e.name).toList();

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
                setState(() {
                  List<String> aux = List.from(selected);
                  aux.contains(n) ? aux.remove(n) : aux.add(n);
                  selected = aux;
                });
                widget.onSelect(selected);
              },
              child: Container(
                padding: const EdgeInsets.all(DefaultPadding.nano),
                decoration: BoxDecoration(
                  color: selected.contains(n) ? CColors.primaryNutrition : CColors.neutral0,
                  border: Border.all(color: CColors.primaryNutrition, width: Layout.borderWidth),
                  borderRadius: const BorderRadius.all(Radius.circular(Layout.borderRadiusMedium)),
                ),
                child: AdaptiveText(
                  text: n,
                  textType: TextType.small,
                  color: selected.contains(n) ? CColors.neutral0 : CColors.primaryNutrition,
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
