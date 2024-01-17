import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

enum _ToastType { success, warning, error }

extension _ToastTypeExtension on _ToastType {
  Color get color {
    switch (this) {
      case _ToastType.success:
        return CColors.success500;
      case _ToastType.warning:
        return CColors.info300;
      case _ToastType.error:
        return CColors.error500;
    }
  }

  IconData get icon {
    switch (this) {
      case _ToastType.success:
        return Icons.check;
      case _ToastType.warning:
        return Icons.error_outline_rounded;
      case _ToastType.error:
        return Icons.close;
    }
  }
}

void successToast(
  BuildContext context,
  String text, {
  Duration fadeDuration = const Duration(milliseconds: 500),
  Duration toastDuration = const Duration(seconds: 3),
}) {
  _showToast(
    context: context,
    text: text,
    type: _ToastType.success,
    fadeDuration: fadeDuration,
    toastDuration: toastDuration,
  );
}

void errorToast(
  BuildContext context,
  String text, {
  Duration fadeDuration = const Duration(milliseconds: 500),
  Duration toastDuration = const Duration(seconds: 3),
}) {
  _showToast(
    context: context,
    text: text,
    type: _ToastType.error,
    fadeDuration: fadeDuration,
    toastDuration: toastDuration,
  );
}

void warningToast(
  BuildContext context,
  String text, {
  Duration fadeDuration = const Duration(milliseconds: 500),
  Duration toastDuration = const Duration(seconds: 3),
}) {
  _showToast(
    context: context,
    text: text,
    type: _ToastType.warning,
    fadeDuration: fadeDuration,
    toastDuration: toastDuration,
  );
}

// ignore: long-parameter-list
void _showToast({
  required BuildContext context,
  required String text,
  required _ToastType type,
  Duration fadeDuration = const Duration(milliseconds: 500),
  Duration toastDuration = const Duration(seconds: 3),
}) {
  final FToast fToast = FToast()..init(context);

  final Widget toast = Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: type.color,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(type.icon, color: CColors.neutral0),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: CColors.neutral0,
              fontWeight: FWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    fadeDuration: fadeDuration,
    toastDuration: toastDuration,
  );
}

void sessionExpiredToast() {
  Fluttertoast.showToast(
    msg: 'Sua sessão expirou. Entre novamente.',
  );
}
