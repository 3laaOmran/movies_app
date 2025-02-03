import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/asset_manager.dart';

class MoviePoster extends StatelessWidget {
  final String imageAsset;
  final String rating;

  MoviePoster({
    required this.imageAsset,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.35,
      height: height * 0.4,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imageAsset,
              fit: BoxFit.cover,
              width: width * 0.35,
              height: height * 0.3,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.02,
              horizontal: width * 0.02,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              width: width * 0.18,
              height: height * 0.04,
              decoration: BoxDecoration(
                color: AppColors.darkGreyColor.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(rating, style: AppStyles.regular16White),
                  Image.asset(AssetsManager.ratingIcon, color: AppColors.yellowColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
