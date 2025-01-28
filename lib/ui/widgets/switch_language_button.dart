import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/asset_manager.dart';

class SwitchLanguageButton extends StatelessWidget {
  const SwitchLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.yellowColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            true
                ? getSelectedIcon(Image.asset(AssetsManager.usaFlag))
                : getUnselectedIcon(Image.asset(AssetsManager.usaFlag)),
            SizedBox(
              width: width * .03,
            ),
            true
                ? getUnselectedIcon(Image.asset(AssetsManager.egyptFlag))
                : getSelectedIcon(Image.asset(AssetsManager.egyptFlag)),
          ],
        ),
      ),
    );
  }

  Widget getSelectedIcon(Widget child) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: AppColors.yellowColor,
          borderRadius: BorderRadius.circular(50)),
      child: child,
    );
  }

  Widget getUnselectedIcon(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: child,
    );
  }
}
