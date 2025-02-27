import 'package:adminpickready/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SChipTheme{
  SChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    checkmarkColor: SColors.white,
    selectedColor: SColors.primary,
    disabledColor: SColors.grey.withOpacity(0.4),
    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12 ),
    labelStyle: const TextStyle(color: SColors.black)
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    checkmarkColor: SColors.white,
    selectedColor: SColors.primary,
    disabledColor: SColors.darkerGrey,
    padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 12 ),
    labelStyle: TextStyle(color: SColors.black)
  );
}