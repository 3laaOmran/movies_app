import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/AddToFavouriteDataModel.dart';
import 'package:movies_app/models/movie_details_model.dart';
import 'package:movies_app/ui/details_screen/cubit/details_screen_cubit.dart';
import 'package:movies_app/ui/details_screen/cubit/details_screen_states.dart';
import 'package:movies_app/ui/details_screen/widgets/custom_container_widget.dart';
import 'package:movies_app/ui/details_screen/widgets/web_view.dart';
import 'package:movies_app/ui/home_screen/tabs/profile/cubit/user_cubit.dart';
import 'package:movies_app/ui/widgets/custom_elevated_button.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/asset_manager.dart';

class MovieDetails extends StatefulWidget {
  Movie movieDetails;

  // String imagePath;
  // String movieName;
  // var rating;
  // var runTime;
  // var likeCount;
  // num year;
  // var url;
  // int movieId;
  MovieDetails({required this.movieDetails
      // required this.movieId,
      // required this.url,
      // required this.imagePath,
      // required this.likeCount,
      // required this.movieName,
      // required this.rating,
      // required this.runTime,
      // required this.year
      });

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  bool isFavourite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DetailsScreenCubit.get(context)
        .checkIsFavourite(widget.movieDetails.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            // alignment:Alignment.center,
            children: [
              CachedNetworkImage(
                height: height * 0.7,
                imageUrl: widget.movieDetails.largeCoverImage ?? "",
                placeholder: (context, url) => Center(
                  child:
                      CircularProgressIndicator(color: AppColors.yellowColor),
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
                    padding: EdgeInsets.only(
                        left: width * 0.02, right: width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              UserCubit.get(context).getFavouriteMovies();
                              Navigator.pop(context);
                              // UserCubit.get(context).getFavouriteMovies();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.whiteColor,
                            )),
                        BlocConsumer<DetailsScreenCubit, DetailsScreenStates>(
                            buildWhen: (previous, current) =>
                                current is IsFavouriteSuccessState,
                            listener: (context, state) {
                              if (state is IsFavouriteSuccessState) {
                                isFavourite = state.isFavouriteModel.data!;
                              }
                            },
                            bloc: DetailsScreenCubit.get(context)
                              ..checkIsFavourite(
                                  widget.movieDetails.id.toString()),
                            builder: (context, state) {
                              // if(state is IsFavouriteSuccessState ){
                              return InkWell(
                                  onTap: () {
                                    if (isFavourite == false) {
                                      var addFavouriteData =
                                          AddToFavouriteDataModel(
                                              imageURL: widget
                                                  .movieDetails.largeCoverImage,
                                              movieId:
                                                  widget
                                                      .movieDetails.id
                                                      .toString(),
                                              name: widget.movieDetails.title,
                                              rating:
                                                  widget.movieDetails.rating,
                                              year: widget.movieDetails.year
                                                  .toString());
                                      addFavouriteData.toJson();
                                      // Todo : add to  favourite
                                      DetailsScreenCubit.get(context)
                                          .addMovieToFavourite(
                                              addFavouriteData:
                                                  addFavouriteData);
                                      // isFavourite=true;
                                      // UserCubit.get(context).getFavouriteMovies();
                                      Future.delayed(
                                        Duration(seconds: 1),
                                        () {
                                          DetailsScreenCubit.get(context)
                                              .checkIsFavourite(widget
                                                  .movieDetails.id
                                                  .toString());
                                        },
                                      );
                                    } else {
                                      // Todo: remove from favourite
                                      DetailsScreenCubit.get(context)
                                          .removeFromFavourite(widget
                                              .movieDetails.id
                                              .toString());
                                      // DetailsScreenCubit.get(context).isFavourite=true;
                                      Future.delayed(
                                        Duration(seconds: 1),
                                        () {
                                          DetailsScreenCubit.get(context)
                                              .checkIsFavourite(widget
                                                  .movieDetails.id
                                                  .toString());
                                        },
                                      );
                                    }
                                    // setState(() {
                                    //
                                    // });
                                  },
                                  child: Image.asset(
                                    AssetsManager.bookmarkIcon,
                                    color: isFavourite
                                        ? AppColors.yellowColor
                                        : Colors.white,
                                  ));
                              // }else{
                              //   return Container();
                              // }
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.21,
                  ),
                  Center(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewScreen(
                                        newsUrl:
                                            widget.movieDetails.url ?? "")));
                          },
                          child: Image.asset(AssetsManager.playIcon))),
                  SizedBox(
                    height: height * 0.17,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.movieDetails.title ?? " ",
                        style: AppStyles.bold24White,
                      ),
                      Text(
                        widget.movieDetails.year.toString(),
                        style: AppStyles.bold20White,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.01),
            child: CustomElevatedButton(
              border: BorderSide(color: AppColors.redColor),
              buttonText: 'Watch',
              buttonTextStyle: AppStyles.bold20White,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewScreen(
                            newsUrl: widget.movieDetails.url ?? " ")));
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
                        number: widget.movieDetails.likeCount ?? "")),
                SizedBox(
                  width: width * 0.02,
                ),
                Expanded(
                    child: CustomContainerWidget(
                        imagePath: AssetsManager.clockIcon,
                        number: widget.movieDetails.runtime)),
                SizedBox(
                  width: width * 0.02,
                ),
                Expanded(
                    child: CustomContainerWidget(
                        imagePath: AssetsManager.ratingIcon,
                        number: widget.movieDetails.rating)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
