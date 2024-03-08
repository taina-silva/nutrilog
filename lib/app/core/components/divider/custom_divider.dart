import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [SizedBox(height: 24), Divider(thickness: 1), SizedBox(height: 24)],
    );
  }
}
