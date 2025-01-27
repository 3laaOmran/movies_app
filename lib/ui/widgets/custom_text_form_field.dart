import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

typedef validation = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final IconData? suffixIcon;
  final String? prefixIcon;
  final bool? isObscure;
  final Function()? onSuffixPressed;
  final TextEditingController controller;
  final Color? borderColor;
  final validation validator;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  const CustomTextFormField(
      {super.key,
      required this.hintText,
      this.hintStyle,
      this.suffixIcon,
      this.prefixIcon,
      this.isObscure,
      required this.controller,
      this.borderColor,
      this.validator,
      this.onChanged,
      this.keyboardType,
      this.onSuffixPressed});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return TextFormField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      obscureText: isObscure ?? false,
      controller: controller,
      style: AppStyles.regular16White,
      cursorColor: Colors.yellow,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: height * 0.02,
        ),
        filled: true,
        fillColor: AppColors.darkGreyColor,
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                child: IconButton(
                  onPressed: onSuffixPressed,
                  icon: Icon(suffixIcon!),
                  color: AppColors.whiteColor,
                ),
              )
            : null,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                child: ImageIcon(
                  AssetImage(prefixIcon!),
                  color: AppColors.whiteColor,
                ),
              )
            : null,
        prefixIconColor: AppColors.whiteColor,
        suffixIconColor: AppColors.whiteColor,
        hintText: hintText,
        hintStyle: AppStyles.regular16White,
        errorStyle: AppStyles.bold12Red,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.redColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.redColor,
          ),
        ),
      ),
    );
  }
}
