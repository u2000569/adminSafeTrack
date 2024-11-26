import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class SAppBarTheme{
  SAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    iconTheme: IconThemeData(color: SColors.iconPrimary, size: SSizes.iconMd),
    actionsIconTheme: IconThemeData(color: SColors.iconPrimary, size: SSizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: SColors.black, fontFamily: 'Urbanist'),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: SColors.dark,
    surfaceTintColor: SColors.dark,
    iconTheme: IconThemeData(color: SColors.black, size: SSizes.iconMd),
    actionsIconTheme: IconThemeData(color: SColors.white, size: SSizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: SColors.white, fontFamily: 'Urbanist'),
  );
}