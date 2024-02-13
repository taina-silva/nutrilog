import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

Future<TimeOfDay?> showCustomTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) {
  return showTimePicker(
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
    initialTime: initialTime,
    helpText: 'SELECIONAR HORA',
    cancelText: 'Cancelar',
    errorInvalidText: 'Data inválida.',
    hourLabelText: 'Hora',
    minuteLabelText: 'Minuto',
  );
}
