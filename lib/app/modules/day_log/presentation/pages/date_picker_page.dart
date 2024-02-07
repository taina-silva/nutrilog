import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/structure/custom_scaffold.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/show_date_picker.dart';

class DatePickerPage extends StatefulWidget {
  final String pathAfterSelectDate;

  const DatePickerPage({
    super.key,
    required this.pathAfterSelectDate,
  });

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      DateTime? date = await showCustomDatePicker(context: context, initialDate: DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: CColors.neutral900.withOpacity(0.5),
    );
  }
}
