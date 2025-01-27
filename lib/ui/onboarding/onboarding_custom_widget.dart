import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../widgets/custom_elevated_button.dart';

class OnboardingCustomWidget extends StatelessWidget {
  OnboardingCustomWidget({required this.title,this.description,required this.button1Text
    ,this.button2Text,this.button2BgColor,required this.image,required this.onPressedNextButton,
    this.onPressedBackButton
  });
  final String title;
  final String? description;
  final String button1Text;
  final String? button2Text;
  final Color? button2BgColor;
  final String image;
  final Function onPressedNextButton;
  final Function? onPressedBackButton;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var screenWidth = 430;
    var screenHeight = 932;
    return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: Image.asset(
              image,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: width * (16 / screenWidth),
              right: width * (16 / screenWidth),
              bottom: height * (20 / screenHeight),
              top: height * (34 / screenHeight),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45)),
                color: AppColors.blackColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  title,
                  style: AppStyles.bold24White,
                ),
                SizedBox(
                  height: height * (24 / screenHeight),
                ),
                description==null?
                    SizedBox():
                Text(
                  textAlign: TextAlign.center,
                  description!,
                  style: AppStyles.regular20White,
                ),
                description==null?
                SizedBox()
                :SizedBox(
                  height: height * (24 / screenHeight),
                ),
                CustomElevatedButton(
                    buttonText: button1Text,
                    buttonTextStyle: AppStyles.semiBold20Black,
                    onPressed: () {
                      onPressedNextButton();
                    }),
                SizedBox(
                  height: height * (16 / screenHeight),
                ),
                button2Text==null?
                SizedBox():
                CustomElevatedButton(
                  bgColor: button2BgColor,
                    buttonText: button2Text!,
                    buttonTextStyle: AppStyles.semiBold20Yellow,
                    onPressed: () {
                    onPressedBackButton!();
                    }),
              ],
            ),
          )
        ],
    );
  }
}
