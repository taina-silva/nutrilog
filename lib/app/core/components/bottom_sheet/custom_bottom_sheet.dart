import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/buttons/custom_button.dart';
import 'package:nutrilog/app/core/utils/constants.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget content;
  final CustomButton? primaryButton;
  final CustomButton? secondaryButton;

  const CustomBottomSheet({
    Key? key,
    required this.content,
    this.primaryButton,
    this.secondaryButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        margin: const EdgeInsets.symmetric(horizontal: ScreenMargin.horizontal),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            content,
            if (primaryButton != null) ...[
              const SizedBox(height: 24),
              primaryButton!,
            ],
            if (secondaryButton != null) ...[
              SizedBox(height: primaryButton != null ? 8 : 24),
              secondaryButton!,
            ],
            SizedBox(height: Layout.bottomPadding(context)),
          ],
        ),
      ),
    );
  }
}
