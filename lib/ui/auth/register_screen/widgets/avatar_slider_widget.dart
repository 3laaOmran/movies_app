import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/auth/register_screen/cubit/register_cubit.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/asset_manager.dart';

class AvatarSliderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    List<String> avatarList = [
      AssetsManager.avatar1,
      AssetsManager.avatar2,
      AssetsManager.avatar3,
      AssetsManager.avatar4,
      AssetsManager.avatar5,
      AssetsManager.avatar6,
      AssetsManager.avatar7,
      AssetsManager.avatar8,
      AssetsManager.avatar9,
    ];
    var cubit=BlocProvider.of<RegisterCubit>(context);
    return Column(
        children: [
        Padding(
         padding: EdgeInsets.symmetric(vertical: height * 0.03),
    child: CarouselSlider.builder(
     options: CarouselOptions(
    height: height * 0.18,
    viewportFraction: 0.39,
    reverse: true,
    enlargeCenterPage: true,
    enlargeFactor: 0.5,
    scrollDirection: Axis.horizontal,
    onPageChanged: (index,reason){
                  cubit.selectAvater(index);
                }
    ),
    itemCount: avatarList.length,
    itemBuilder:
    (BuildContext context, int itemIndex, int pageViewIndex) =>
    Image.asset(
    avatarList[itemIndex],
    fit: BoxFit.fill,
    ),
    ),
    ),
    Text(
    'Avatar',
    style: AppStyles.regular16White,
    ),
    SizedBox(height: height * 0.01),
    ],
    );
  }
}
