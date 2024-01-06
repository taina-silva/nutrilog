import 'package:flutter/services.dart';

class CoordinateInputFormatter extends TextInputFormatter {
  String formatCoordinate(String input) {
    bool hasMinus = input.substring(0, 1) == '-';
    int dot = input.indexOf('.');

    if (dot != -1) {
      String beforeDot = input.substring(0, dot);
      String afterDot = input.substring(dot + 1, input.length);
      afterDot = afterDot.replaceAll('.', '');

      input = '$beforeDot.$afterDot';
    }

    input = input.replaceAll(RegExp('[^0-9.]'), '');
    return (hasMinus ? '-' : '') + input;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    return newValue.copyWith(
        text: formatCoordinate(text),
        selection: TextSelection.collapsed(offset: formatCoordinate(text).length));
  }
}
