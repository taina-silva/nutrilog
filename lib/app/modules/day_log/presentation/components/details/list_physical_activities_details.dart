import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/list_physical_activities_model.dart';
import 'package:nutrilog/app/core/infra/models/physical_activity/physical_activity_model.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

class ListPhysicalActivitiesWidget extends StatefulWidget {
  final ListPhysicalActivitiesModel list;
  final PhysicalActivityModel? initalSelected;
  final void Function(String) onSelect;

  const ListPhysicalActivitiesWidget({
    super.key,
    required this.list,
    required this.initalSelected,
    required this.onSelect,
  });

  @override
  State<ListPhysicalActivitiesWidget> createState() => _ListPhysicalActivitiesWidgetState();
}

class _ListPhysicalActivitiesWidgetState extends State<ListPhysicalActivitiesWidget> {
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
          children: widget.list.list.map((p) {
            return GestureDetector(
              onTap: () {
                setState(() => selected = p);
                widget.onSelect(p);
              },
              child: Container(
                padding: const EdgeInsets.all(DefaultPadding.nano),
                decoration: BoxDecoration(
                  color: p == selected && widget.initalSelected?.type == widget.list.type
                      ? CColors.primaryActivity
                      : CColors.neutral0, 
                  border: Border.all(color: CColors.primaryActivity, width: Layout.borderWidth),
                  borderRadius: const BorderRadius.all(Radius.circular(Layout.borderRadiusMedium)),
                ),
                child: AdaptiveText(text: p, textType: TextType.small),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
