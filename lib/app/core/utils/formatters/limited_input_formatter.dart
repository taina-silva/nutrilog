import 'package:flutter/services.dart';

class LimitedInputFormatter extends TextInputFormatter {
  final bool enableComma;
  final int before;
  final int after;

  LimitedInputFormatter({this.enableComma = true, required this.before, required this.after});

  String completeString(String word, int tam) {
    String spaces = List.filled(tam - word.length, '0').join();
    return word + spaces;
  }

  String formatLimited(String newInput, String oldInput) {
    newInput = newInput.replaceAll(RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%A-Za-z-]'), '');
    newInput = newInput.replaceAll(' ', '');
    newInput = newInput.replaceAll('.', '');
    newInput = newInput.replaceAll(',', '');

    if (newInput.isEmpty) return '';

    if (!enableComma) {
      newInput = newInput.replaceAll(',', '');
      if (newInput.length > before) newInput = newInput.substring(0, before);
      return newInput;
    }

    while (newInput.isNotEmpty && newInput[0] == '0') {
      newInput = newInput.replaceFirst('0', '');
    }

    String beforeComma = '';
    String afterComma = '';

    if (newInput.length <= after) {
      afterComma = newInput;
      if (afterComma.length < after) {
        afterComma = completeString(afterComma, after);
        afterComma = afterComma.split('').reversed.join('');
      }
      beforeComma = '0';
    } else {
      String newReversed = newInput.split('').reversed.join('');
      afterComma = newReversed.substring(0, after);
      beforeComma = newReversed.substring(after, newReversed.length);
      afterComma = afterComma.split('').reversed.join('');
      beforeComma = beforeComma.split('').reversed.join('');
    }

    if (beforeComma.length > before) return oldInput;

    return '$beforeComma,$afterComma';
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    String oldText = oldValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String formatted = formatLimited(newText, oldText);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.isEmpty ? -1 : formatted.length),
    );
  }
}
