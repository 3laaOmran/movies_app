import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../../utils/app_colors.dart';

class CustomDialog {
  static void showLoading({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.darkGreyColor,
            content: Row(
              children: [
                CircularProgressIndicator(
                  color: AppColors.yellowColor,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  message,
                  style: AppStyles.regular16White,
                )
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showAlert({
    required BuildContext context,
    required String message,
    String title = '',
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionName,
            style: AppStyles.bold14Yellow,
          )));
    }
    if (negActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            negActionName,
            style: AppStyles.bold14Yellow,
          )));
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.darkGreyColor,
            title: Text(
              title,
              style: AppStyles.bold20Yellow,
            ),
            content: Text(
              message,
              style: AppStyles.regular16White,
            ),
            actions: actions,
          );
        });
  }
}
