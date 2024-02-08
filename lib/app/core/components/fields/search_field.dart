import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/utils/constants.dart';

class SearchField extends StatelessWidget {
  final void Function(String) onChanged;
  final TextEditingController controller;
  final Color iconColor;
  final String hintText;

  const SearchField({
    super.key,
    required this.onChanged,
    required this.controller,
    required this.iconColor,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: Icon(controller.text.isEmpty ? Icons.search : Icons.close, color: iconColor),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Layout.borderRadiusSmall),
        ),
      ),
    );
  }
}
