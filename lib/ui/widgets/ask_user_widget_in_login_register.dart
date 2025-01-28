import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';

class AskUserWidgetInLoginRegister extends StatelessWidget {
  final String question;
  final String textButtonText;
  final GestureTapCallback onPressed;

  const AskUserWidgetInLoginRegister(
      {super.key,
      required this.question,
      required this.textButtonText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: question,
        style: AppStyles.regular14White,
      ),
      TextSpan(
          text: textButtonText,
          style: AppStyles.bold14Yellow,
          recognizer: TapGestureRecognizer()..onTap = onPressed),
    ]));
  }
}
