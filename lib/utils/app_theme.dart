import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.blackColor,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.blackColor,
    ),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.yellowColor),
        centerTitle: true,
        backgroundColor: AppColors.blackColor,
        titleTextStyle: AppStyles.regular16Yellow),
  );
}
