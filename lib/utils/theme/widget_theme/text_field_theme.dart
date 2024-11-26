import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class STextFormFieldTheme {
  STextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: SColors.darkGrey,
    suffixIconColor: SColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: SSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: SSizes.fontSizeMd, color: SColors.textPrimary, fontFamily: 'Urbanist'),
    hintStyle: const TextStyle().copyWith(fontSize: SSizes.fontSizeSm, color: SColors.textSecondary, fontFamily: 'Urbanist'),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal, fontFamily: 'Urbanist'),
    floatingLabelStyle: const TextStyle().copyWith(color: SColors.textSecondary, fontFamily: 'Urbanist'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.borderPrimary),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.borderPrimary),
    ),
    focusedBorder:const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.borderSecondary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: SColors.error),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: SColors.darkGrey,
    suffixIconColor: SColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: SSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: SSizes.fontSizeMd, color: SColors.white, fontFamily: 'Urbanist'),
    hintStyle: const TextStyle().copyWith(fontSize: SSizes.fontSizeSm, color: SColors.white, fontFamily: 'Urbanist'),
    floatingLabelStyle: const TextStyle().copyWith(color: SColors.white.withOpacity(0.8), fontFamily: 'Urbanist'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: SColors.error),
    ),
  );
}
