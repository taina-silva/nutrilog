enum FormatNumbersType {
  withoutDecimals,
  withDynamicDecimals,
  withOneFixedDecimals,
  withFixedDecimals,
}

FormatNumbersType formatNumbersTypeFromInt(int roundValue) {
  switch (roundValue) {
    case 0:
      return FormatNumbersType.withoutDecimals;
    case 1:
      return FormatNumbersType.withOneFixedDecimals;
    case 2:
      return FormatNumbersType.withFixedDecimals;
    default:
      return FormatNumbersType.withFixedDecimals;
  }
}

String formatNumbers(
  double value, {
  FormatNumbersType type = FormatNumbersType.withDynamicDecimals,
}) {
  final String stringifiedValue = value.toString();
  final String integerPart = stringifiedValue.split('.').first;
  final String rationalPart = stringifiedValue.split('.')[1];
  if (type == FormatNumbersType.withFixedDecimals) {
    return rationalPart.length == 1
        ? '${_formatIntegerNumber(int.parse(integerPart))},${rationalPart.substring(0, 1)}0'
        : '${_formatIntegerNumber(int.parse(integerPart))},${rationalPart.substring(0, 2)}';
  }
  if (type == FormatNumbersType.withOneFixedDecimals) {
    return '${_formatIntegerNumber(int.parse(integerPart))},${rationalPart.substring(0, 1)}';
  }
  if (type == FormatNumbersType.withoutDecimals || int.parse(rationalPart) == 0) {
    return _formatIntegerNumber(int.parse(integerPart));
  }
  if (rationalPart.length == 1) {
    return '${_formatIntegerNumber(int.parse(integerPart))},${rationalPart.substring(0, 1)}';
  }

  return '${_formatIntegerNumber(int.parse(integerPart))},${rationalPart.substring(0, 2)}';
}

String _formatIntegerNumber(int value) {
  if (value >= 1000 || value <= -1000) {
    final valueAsList = value.toString().replaceAll('-', '').split('');
    String outputReversed = '';
    int i = 0;
    for (int j = valueAsList.length - 1; j >= 0; j--) {
      outputReversed += valueAsList[j];
      if ((i + 1) % 3 == 0 && (i + 1) != valueAsList.length) {
        outputReversed += '.';
      }
      i++;
    }
    String formattedNumber = '';
    if (value.isNegative) {
      formattedNumber += '-';
    }

    return formattedNumber += outputReversed.split('').reversed.toList().join();
  }

  return value.toString();
}

enum FormatTimeType {
  withoutSeconds,
  withSeconds,
}

String formatTime(DateTime date, {FormatTimeType type = FormatTimeType.withoutSeconds}) {
  final String hours = date.hour < 10 ? '0${date.hour}' : '${date.hour}';
  final String minutes = date.minute < 10 ? '0${date.minute}' : '${date.minute}';
  final String seconds = date.second < 10 ? '0${date.second}' : '${date.second}';
  if (type == FormatTimeType.withoutSeconds) {
    return '$hours:$minutes';
  }

  return '$hours:$minutes:$seconds';
}

enum FormatDateType {
  completeYear,
  withoutYear,
  shortYear,
}

String formatDate(DateTime date, {FormatDateType type = FormatDateType.completeYear}) {
  final String day = date.day < 10 ? '0${date.day}' : '${date.day}';
  final String month = date.month < 10 ? '0${date.month}' : '${date.month}';
  if (type == FormatDateType.withoutYear) {
    return '$day/$month';
  }
  if (type == FormatDateType.shortYear) {
    return '$day/$month/${date.year.toString().substring(2)}';
  }

  return '$day/$month/${date.year}';
}

String formatCoordinate(String input) {
  String first = input.substring(0);

  if (first == '-') input.replaceAll('-', '');
  input.replaceAll('.', '');

  if (input.length >= 3) {
    String firstPart = input.substring(0, 1);
    String secPart = input.substring(2, input.length - 1);

    return '$firstPart.$secPart';
  }

  return input;
}
