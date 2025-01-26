import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? bgColor;
  final String buttonText;
  final TextStyle? buttonTextStyle;
  final Widget? buttonWidget;
  final void Function() onPressed;
  final BorderSide? border;

  const CustomElevatedButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.border,
      this.bgColor,
      this.buttonWidget,
      this.buttonTextStyle});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: height * 0.015),
            shape: RoundedRectangleBorder(
              side: border ??
                  BorderSide(
                    width: 2,
                    color: AppColors.yellowColor,
                  ),
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: bgColor ?? AppColors.yellowColor,
          ),
          onPressed: onPressed,
          child: buttonWidget == null
              ? Text(
                  buttonText,
                  style: buttonTextStyle ?? AppStyles.regular20Black,
                )
              : buttonWidget),
    );
  }
}
