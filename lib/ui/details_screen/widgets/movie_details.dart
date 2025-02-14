import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/details_screen/widgets/custom_container_widget.dart';
import 'package:movies_app/ui/details_screen/widgets/web_view.dart';
import 'package:movies_app/ui/widgets/custom_elevated_button.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/asset_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieDetails extends StatelessWidget {
  String imagePath;
  String movieName;
  var rating;
  var runTime;
  var likeCount;
  num year;
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(children: [
        Stack(
          alignment: Alignment.bottomCenter,
          // alignment:Alignment.center,
          children: [
            CachedNetworkImage(
              height: height*0.7,
              imageUrl:  imagePath,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(color: AppColors.yellowColor),
              ),
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.error, color: Colors.red, size: 35),
              ),
            ),
            Container(
              width: double.infinity,
              height: height * 0.7,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(230, 0, 0, 0),
                    Color.fromARGB(150, 0, 0, 0),
                    Color.fromARGB(100, 0, 0, 0),
                    Color.fromARGB(230, 12, 13, 12),
                  ],
                  stops: [0.0, 0.3, 0.6, 1.0],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: width*0.02,right: width*0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                   IconButton(onPressed: (){
                     Navigator.pop(context);
                   }, icon: Icon( Icons.arrow_back_ios,color: AppColors.whiteColor,)),
                    InkWell(
                        child: Image.asset(
                          AssetsManager.bookmarkIcon,color: AppColors.whiteColor,))
                  ],),
                ),
                SizedBox(height: height*0.19,),
                Center(
                    child: InkWell(
                    onTap: (){
                      Navigator.push( context, MaterialPageRoute( builder: (context) =>
                          WebViewScreen(newsUrl: url)));
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
              Navigator.push( context, MaterialPageRoute( builder: (context) =>
                  WebViewScreen(newsUrl: url)));

              },
              bgColor: AppColors.redColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: CustomContainerWidget(
                        imagePath: AssetsManager.favoriteIcon,
                        number: likeCount)),
                SizedBox(
                  width: width * 0.02,
                ),
                Expanded(
                    child: CustomContainerWidget(
                        imagePath: AssetsManager.clockIcon, number: runTime)),
                SizedBox(
                  width: width * 0.02,
                ),
                Expanded(
                    child: CustomContainerWidget(
                        imagePath: AssetsManager.ratingIcon, number: rating)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
