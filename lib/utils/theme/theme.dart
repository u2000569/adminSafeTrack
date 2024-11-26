import 'package:adminpickready/utils/theme/widget_theme/text_theme.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'widget_theme/app_bar_theme.dart';
import 'widget_theme/bottom_sheet_theme.dart';
import 'widget_theme/check_box_theme.dart';
import 'widget_theme/chip_theme.dart';
import 'widget_theme/elevated_button_theme.dart';
import 'widget_theme/outlined_button_theme.dart';
import 'widget_theme/text_field_theme.dart';

class SAppTheme{
  SAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Urbanist',
    disabledColor: SColors.grey,
    brightness: Brightness.light,
    primaryColor: SColors.primary,
    textTheme: STextTheme.lightTextTheme,
    chipTheme: SChipTheme.lightChipTheme,
    appBarTheme: SAppBarTheme.lightAppBarTheme,
    checkboxTheme: SCheckboxTheme.lightCheckboxTheme,
    scaffoldBackgroundColor: SColors.primaryBackground,
    bottomSheetTheme: SBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.lightInputDecorationTheme,
    

  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Urbanist',
    disabledColor: SColors.grey,
    brightness: Brightness.dark,
    primaryColor: SColors.primary,
    textTheme: STextTheme.darkTextTheme,
    chipTheme: SChipTheme.darkChipTheme,
    appBarTheme: SAppBarTheme.darkAppBarTheme,
    checkboxTheme: SCheckboxTheme.darkCheckboxTheme,
    scaffoldBackgroundColor: SColors.primary.withOpacity(0.1),
    bottomSheetTheme: SBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.darkInputDecorationTheme,
  );
}