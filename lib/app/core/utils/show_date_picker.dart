import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/utils/date_extension.dart';

Future<DateTime?> showCustomDatePicker({
  required BuildContext context,
  required DateTime initialDate,
}) {
  return showDatePicker(
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
