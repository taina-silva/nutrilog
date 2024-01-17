import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/components/text/auto_size_text.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

class CustomButton extends StatelessWidget {
  final ButtonParameters params;
  final ButtonType type;

  const CustomButton._(this.params, this.type);

  factory CustomButton.primaryNeutroNano(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.nano), ButtonType.primaryNeutro);
  }

  factory CustomButton.primaryNeutroSmall(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.small), ButtonType.primaryNeutro);
  }

  factory CustomButton.primaryNeutroMedium(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.medium), ButtonType.primaryNeutro);
  }

  factory CustomButton.primaryNeutroLarge(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.large), ButtonType.primaryNeutro);
  }

  factory CustomButton.primaryActivityNano(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.nano), ButtonType.primaryActivity);
  }

  factory CustomButton.primaryActivitySmall(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.small), ButtonType.primaryActivity);
  }

  factory CustomButton.primaryActivityMedium(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.medium), ButtonType.primaryActivity);
  }

  factory CustomButton.primaryActivityLarge(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.large), ButtonType.primaryActivity);
  }

  factory CustomButton.primaryNutritionNano(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.nano), ButtonType.primaryNutrition);
  }

  factory CustomButton.primaryNutritionSmall(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.small), ButtonType.primaryNutrition);
  }

  factory CustomButton.primaryNutritionMedium(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.medium), ButtonType.primaryNutrition);
  }

  factory CustomButton.primaryNutritionLarge(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.large), ButtonType.primaryNutrition);
  }

  factory CustomButton.secondaryNeutroNano(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.nano), ButtonType.secondaryNeutro);
  }

  factory CustomButton.secondaryNeutroSmall(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.small), ButtonType.secondaryNeutro);
  }

  factory CustomButton.secondaryNeutroMedium(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.medium), ButtonType.secondaryNeutro);
  }

  factory CustomButton.secondaryNeutroLarge(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.large), ButtonType.secondaryNeutro);
  }

  factory CustomButton.secondaryActivityNano(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.nano), ButtonType.secondaryActivity);
  }

  factory CustomButton.secondaryActivitySmall(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.small), ButtonType.secondaryActivity);
  }

  factory CustomButton.secondaryActivityMedium(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.medium), ButtonType.secondaryActivity);
  }

  factory CustomButton.secondaryActivityLarge(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.large), ButtonType.secondaryActivity);
  }

  factory CustomButton.secondaryNutritionNano(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.nano), ButtonType.secondaryNutrition);
  }

  factory CustomButton.secondaryNutritionSmall(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.small), ButtonType.secondaryNutrition);
  }

  factory CustomButton.secondaryNutritionMedium(ButtonParameters params) {
    return CustomButton._(
        params.copyWith(textType: TextType.medium), ButtonType.secondaryNutrition);
  }

  factory CustomButton.secondaryNutritionLarge(ButtonParameters params) {
    return CustomButton._(params.copyWith(textType: TextType.large), ButtonType.secondaryNutrition);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Botão: ${params.text}",
      child: GestureDetector(
        onTap: !params.isDisabled && !params.isLoading ? params.onTap : null,
        child: Container(
          height: params.height,
          width: params.width,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Layout.borderRadiusSmall),
            color: _backgroundColor,
            border: Border.all(
              width: 1,
              color: _borderColor,
            ),
          ),
          child: params.isLoading ? _buttonLoading : _buttonContent,
        ),
      ),
    );
  }

  Widget get _buttonLoading {
    return Center(
      child: SizedBox(
        height: params.height / 2,
        width: params.height / 2,
        child: CircularProgressIndicator(
          color: _contentColor,
          strokeWidth: params.height / 15,
        ),
      ),
    );
  }

  Widget get _buttonContent {
    List<Widget> content = [
      if (params.prefixIcon != null) ...[
        Icon(
          params.prefixIcon,
          size: params.iconsSize,
          color: _contentColor,
        ),
        const SizedBox(width: 8),
      ],
      Center(
        child: AdaptiveText(
          text: params.text,
          textAlign: TextAlign.center,
          textType: params.textType,
          fWeight: FWeight.bold,
          color: _contentColor,
        ),
      ),
      if (params.suffixIcon != null) ...[
        const SizedBox(width: 8),
        Icon(
          params.suffixIcon,
          size: params.iconsSize,
          color: _contentColor,
        ),
      ],
    ];

    return Container(
      margin: EdgeInsets.only(
        left: params.contentAlignment == ButtonContentAlignment.left ? 20 : 0,
        right: params.contentAlignment == ButtonContentAlignment.right ? 20 : 0,
      ),
      child: Row(
        mainAxisAlignment: () {
          switch (params.contentAlignment) {
            case ButtonContentAlignment.left:
              return MainAxisAlignment.start;
            case ButtonContentAlignment.right:
              return MainAxisAlignment.end;
            case ButtonContentAlignment.center:
              return MainAxisAlignment.center;
            default:
              return MainAxisAlignment.center;
          }
        }(),
        children: content,
      ),
    );
  }

  Color get _backgroundColor {
    switch (type) {
      case ButtonType.primaryNeutro:
        if (params.isDisabled) return CColors.neutral300;
        return params.overrideBackgroundColor ?? CColors.neutral900;
      case ButtonType.primaryActivity:
        if (params.isDisabled) return CColors.neutral300;
        return params.overrideBackgroundColor ?? CColors.primaryActivity;
      case ButtonType.primaryNutrition:
        if (params.isDisabled) return CColors.neutral300;
        return params.overrideBackgroundColor ?? CColors.primaryNutrition;

      case ButtonType.secondaryNeutro ||
            ButtonType.secondaryActivity ||
            ButtonType.secondaryNutrition:
        return CColors.neutral0;
    }
  }

  Color get _borderColor {
    switch (type) {
      case ButtonType.primaryNeutro || ButtonType.primaryActivity || ButtonType.primaryNutrition:
        return Colors.transparent;
      case ButtonType.secondaryNeutro:
        if (params.isDisabled) return CColors.neutral500;
        return params.overrideBackgroundColor ?? CColors.neutral900;
      case ButtonType.secondaryActivity:
        if (params.isDisabled) return CColors.neutral500;
        return params.overrideBackgroundColor ?? CColors.primaryActivity;
      case ButtonType.secondaryNutrition:
        if (params.isDisabled) return CColors.neutral500;
        return params.overrideBackgroundColor ?? CColors.primaryNutrition;
    }
  }

  Color get _contentColor {
    switch (type) {
      case ButtonType.primaryNeutro || ButtonType.primaryActivity || ButtonType.primaryNutrition:
        if (params.isDisabled) return CColors.neutral700;
        return CColors.neutral0;
      case ButtonType.secondaryNeutro:
        if (params.isDisabled) return CColors.neutral500;
        return params.overrideBackgroundColor ?? CColors.neutral900;
      case ButtonType.secondaryActivity:
        if (params.isDisabled) return CColors.neutral500;
        return params.overrideBackgroundColor ?? CColors.primaryActivity;
      case ButtonType.secondaryNutrition:
        if (params.isDisabled) return CColors.neutral500;
        return params.overrideBackgroundColor ?? CColors.primaryNutrition;
    }
  }
}

enum ButtonType {
  primaryNeutro,
  secondaryNeutro,
  primaryActivity,
  secondaryActivity,
  primaryNutrition,
  secondaryNutrition,
}

enum ButtonContentAlignment {
  left,
  center,
  right,
}

class ButtonParameters extends Equatable {
  final String text;
  final TextType textType;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final int maxLines;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double iconsSize;
  final bool isDisabled;
  final bool isLoading;
  final Color? overrideBackgroundColor;
  final ButtonContentAlignment? contentAlignment;

  const ButtonParameters({
    required this.text,
    this.textType = TextType.nano,
    this.onTap,
    this.width = double.infinity,
    this.height = 52,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.iconsSize = 20,
    this.isLoading = false,
    this.isDisabled = false,
    this.overrideBackgroundColor,
    this.contentAlignment = ButtonContentAlignment.center,
  });

  @override
  List<Object?> get props {
    return [
      text,
      textType,
      isLoading,
      onTap,
      width,
      height,
      maxLines,
      prefixIcon,
      suffixIcon,
      isDisabled,
      iconsSize,
      overrideBackgroundColor,
      contentAlignment,
    ];
  }

  ButtonParameters copyWith({
    String? text,
    TextType? textType,
    bool? isLoading,
    VoidCallback? onTap,
    double? width,
    double? height,
    int? maxLines,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool? isDisabled,
    double? iconsSize,
    bool? displayAsColumn,
    Color? overrideBackgroundColor,
    ButtonContentAlignment? contentAlignment,
  }) {
    return ButtonParameters(
      text: text ?? this.text,
      textType: textType ?? this.textType,
      isLoading: isLoading ?? this.isLoading,
      onTap: onTap ?? this.onTap,
      width: width ?? this.width,
      height: height ?? this.height,
      maxLines: maxLines ?? this.maxLines,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      isDisabled: isDisabled ?? this.isDisabled,
      iconsSize: iconsSize ?? this.iconsSize,
      overrideBackgroundColor: overrideBackgroundColor ?? this.overrideBackgroundColor,
      contentAlignment: contentAlignment ?? this.contentAlignment,
    );
  }
}
