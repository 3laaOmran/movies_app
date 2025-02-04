import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/asset_manager.dart';

class MoviePoster extends StatelessWidget {
  final String networkImage;
  final String rating;
  final double imageWidth;
  final double imageHeight;
  final BoxFit imageFit;

  MoviePoster({
    required this.networkImage,
    required this.rating,
    required this.imageWidth,
    required this.imageHeight,
    required this.imageFit,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap:(){
        // TODO: Navigate to movie details screen
      },
      child: Container(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: networkImage,
                fit: imageFit,
                width: imageWidth,
                //width * 0.35,
                height: imageHeight,
                //height * 0.3,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(color: AppColors.yellowColor),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.01, vertical: height * 0.01),
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.012, vertical: height * 0.002),
              decoration: BoxDecoration(
                color: AppColors.darkGreyColor.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    rating,
                    style: AppStyles.regular16White,
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  ImageIcon(
                    AssetImage(AssetsManager.ratingIcon),
                    size: width * 0.04,
                    color: AppColors.yellowColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
