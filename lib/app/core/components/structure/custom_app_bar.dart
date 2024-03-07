import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

class CustomAppBar extends StatefulWidget {
  final Either<String, Widget> title;
  final List<Widget>? trailing;
  final Widget? leading;
  final Color? backgroundColor;
  final CrossAxisAlignment appBarItemsAlignment;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.trailing,
    this.leading,
    this.backgroundColor,
    this.appBarItemsAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? CColors.primaryBackground,
        boxShadow: [Layout.boxShadow],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: DefaultMargin.horizontal),
            child: Column(
              children: [
                SizedBox(
                  height: Layout.appBarSize,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: widget.appBarItemsAlignment,
                    children: [
                      _renderAppBarLeading(context),
                      Expanded(
                        child: widget.title.fold(
                          (title) => GestureDetector(
                            onTap: canPop() ? () => Modular.to.pop() : null,
                            child: AdaptiveText(
                              text: title,
                              textType: TextType.large,
                              fWeight: FWeight.bold,
                              color: CColors.neutral900,
                            ),
                          ),
                          (widget) => Container(
                            alignment: Alignment.bottomLeft,
                            child: widget,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: Layout.appBarTrailingHeight,
                          child: _renderAppBarTrailing(context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool canPop() => Modular.to.canPop();

  Widget _renderAppBarLeading(BuildContext context) {
    if (widget.leading != null) {
      return Container(
        margin: const EdgeInsets.only(right: Layout.appBarLeadingAndTrailingWidth / 4),
        child: widget.leading!,
      );
    }

    if (canPop()) {
      return Container(
        margin: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () => Modular.to.pop(),
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: CColors.neutral900,
            size: Layout.appBarLeadingAndTrailingWidth,
            semanticLabel: 'Voltar para a página anterior',
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Widget _renderAppBarTrailing(BuildContext context) {
    if (widget.trailing != null) {
      return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.trailing!.length,
        itemBuilder: (BuildContext context, int index) {
          return widget.trailing![index];
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 16);
        },
      );
    }

    const defaultTrailings = [];

    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: defaultTrailings.length,
      itemBuilder: (BuildContext context, int index) {
        return defaultTrailings[index];
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 16);
      },
    );
  }
}
