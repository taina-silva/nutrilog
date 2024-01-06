import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

Future<void> showCustomBottomSheet({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  bool isDismissible = true,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    isDismissible: isDismissible,
    backgroundColor: CColors.neutral0,
    builder: builder,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Layout.borderRadiusMedium)),
    ),
  );
}
