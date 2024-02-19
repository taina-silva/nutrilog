import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

class RadiosSelectWidget<T> extends StatefulWidget {
  final List<T> options;
  final T? initialOption;
  final String Function(T item) text;
  final void Function(T item) onTap;
  final Color primaryColor;
  final bool displayAsRow;

  const RadiosSelectWidget({
    super.key,
    required this.options,
    required this.initialOption,
    required this.text,
    required this.onTap,
    required this.primaryColor,
    this.displayAsRow = false,
  });

  @override
  State<RadiosSelectWidget<T>> createState() => _RadiosSelectWidgetState<T>();
}

class _RadiosSelectWidgetState<T> extends State<RadiosSelectWidget<T>> {
  T? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialOption;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: widget.displayAsRow
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: widget.options.map((item) => _widget(item)).toList(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.options.map((item) => _widget(item)).toList(),
            ),
    );
  }

  Widget _widget(T item) {
    return Container(
      margin: EdgeInsets.only(
        bottom: widget.displayAsRow
            ? 0
            : (widget.options.indexOf(item) < widget.options.length - 1 ? 24 : 0),
        right: !widget.displayAsRow
            ? 0
            : (widget.options.indexOf(item) < widget.options.length - 1 ? 24 : 0),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() => selected = item);
          widget.onTap(selected as T);
        },
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: item == selected ? CColors.neutral0 : CColors.neutral0,
                border: Border.all(
                  color: item == selected ? widget.primaryColor : CColors.neutral600,
                  width: Layout.borderWidth,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(Layout.borderRadiusBig)),
              ),
              child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: item == selected ? widget.primaryColor : CColors.neutral0,
                  borderRadius: const BorderRadius.all(Radius.circular(Layout.borderRadiusBig)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            AdaptiveText(
              text: widget.text(item),
              textType: TextType.medium,
              fWeight: FWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
