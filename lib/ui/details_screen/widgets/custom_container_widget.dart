import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class CustomContainerWidget extends StatelessWidget {
String imagePath;
var number;
CustomContainerWidget({required this.imagePath,required this.number});
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.darkGreyColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: width*0.01,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(imagePath),
          SizedBox(width: width*0.01,),
          Text('$number',style: AppStyles.bold24White,),
        ],),
    );
  }
}
