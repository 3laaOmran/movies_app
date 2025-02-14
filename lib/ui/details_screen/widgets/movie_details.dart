import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/details_screen/widgets/custom_container_widget.dart';
import 'package:movies_app/ui/widgets/custom_elevated_button.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/asset_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatelessWidget {
  String imagePath;
  String movieName;
  var rating;
  var runTime;
  var likeCount;
  int year;
  var url;
  MovieDetails({
    required this.url,
    required this.imagePath,
    required this.likeCount,
    required this.movieName,
    required this.rating,
    required this.runTime,
    required this.year
});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(children: [
        Stack(
          alignment: Alignment.bottomCenter,
          // alignment:Alignment.center,
          children: [
            Opacity(
              opacity: 0.5,
              child: CachedNetworkImage(
                imageUrl:  imagePath,
              )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(child: InkWell(
                    onTap: (){
                      launch(url);
                    },
                    child: Image.asset(AssetsManager.playIcon))),
               SizedBox(height: height*0.17,),
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                 Text(movieName,style: AppStyles.bold24White,),
                 Text('$year',style: AppStyles.bold20White,),
               ],)
            ],)
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.01),
          child: CustomElevatedButton(
            border: BorderSide(color: AppColors.redColor),
            buttonText: 'Watch',
            buttonTextStyle: AppStyles.bold20White,
            onPressed: (){
                launch(url);
              },
            bgColor: AppColors.redColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Expanded(child: CustomContainerWidget(imagePath:AssetsManager.favoriteIcon , number: likeCount)),
          SizedBox(width: width*0.02,),
            Expanded(child: CustomContainerWidget(imagePath:AssetsManager.clockIcon , number: runTime)),
            SizedBox(width: width*0.02,),
            Expanded(child: CustomContainerWidget(imagePath:AssetsManager.ratingIcon , number: rating )),
          ],),
        )
      ],
      ),
    );
  }
}
