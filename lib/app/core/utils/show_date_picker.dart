import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';
import 'package:nutrilog/app/core/utils/date_extension.dart';

Future<DateTime?> showCustomDatePicker({
  required BuildContext context,
  required DateTime initialDate,
}) {
  return showDatePicker(
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
              primary: CColors.neutral900,
              onPrimary: CColors.neutral0,
              onSurface: CColors.neutral900),
        ),
        child: child!,
      );
    },
    context: context,
    firstDate: DateTime.parse('2020-01-01'),
    lastDate: DateTime.now().datetimeWithTimeReset(),
    initialDate: initialDate.datetimeWithTimeReset(),
    initialEntryMode: DatePickerEntryMode.calendar,
    helpText: 'SELECIONAR DATA',
    cancelText: 'Cancelar',
    errorFormatText: 'Data em formato inválido.',
    errorInvalidText: 'Data inválida.',
    fieldHintText: 'Data',
    fieldLabelText: 'Data',
    locale: const Locale("pt", "BR"),
  );
}
