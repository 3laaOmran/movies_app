import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/di/di.dart';
import 'package:movies_app/ui/auth/login_screen/login_screen.dart';
import 'package:movies_app/ui/home_screen/tabs/browse_tab/cubit/browse_tab_view_model.dart';
import 'package:movies_app/ui/home_screen/tabs/profile/cubit/user_cubit.dart';
import 'package:movies_app/ui/home_screen/tabs/profile/update_profile/update_profile.dart';
import 'package:movies_app/ui/widgets/custom_elevated_button.dart';
import 'package:movies_app/ui/widgets/movie_poster.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/asset_manager.dart';
import 'package:movies_app/utils/helpers/cash_helper.dart';

import '../../../../details_screen/details_screen.dart';
import '../../../../widgets/custom_dialog.dart';
import '../cubit/user_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserCubit cubit = getIt<UserCubit>();

  @override
  void initState() {
    super.initState();
    if (CashHelper.getData(key: 'googleUsername') == null) {
      cubit.getUserData();
    } else {
      cubit.getGoogleUserDetails();
      cubit.nameController.text = CashHelper.getData(key: 'googleUsername');
      cubit.googleUserImage = CashHelper.getData(key: 'googleUserImage');
    }
    UserCubit.get(context).getFavouriteMovies();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
    return BlocConsumer<UserCubit, UserStates>(
      bloc: cubit,
      listener: (context, state) {
        if (state is GetUserDataSuccessState) {
          cubit.nameController.text = state.user.name ?? "";
          cubit.phoneController.text = state.user.phone ?? "";
          int avatarId = state.user.avaterId ?? 0;
          if (avatarId >= avatarList.length) {
            avatarId = 0;
          }
          cubit.selectedAvatarId = avatarId;
        }
      },
      builder: (context, state) {
        if (state is GetUserDataSuccessState) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: AppColors.blackColor,
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    backgroundColor: AppColors.darkGreyColor,
                    expandedHeight: height * 0.46,
                    pinned: true,
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.zero,
                      centerTitle: true,
                      title: Container(
                        color: AppColors.darkGreyColor,
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          indicatorColor: AppColors.yellowColor,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelPadding: EdgeInsets.only(bottom: height * 0.005),
                          tabs: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.list,
                                    color: AppColors.yellowColor, size: 30),
                                Text('Watch List',
                                    style: AppStyles.regular14White),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.folder,
                                    color: AppColors.yellowColor),
                                Text('History',
                                    style: AppStyles.regular14White),
                              ],
                            ),
                          ],
                        ),
                      ),
                      background: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.08),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                        avatarList[state.user.avaterId ?? 0],
                                        width: 110),
                                    SizedBox(height: height * 0.02),
                                    Text(state.user.name ?? '',
                                        style: AppStyles.bold20White),
                                  ],
                                ),
                                Column(
                                  children: [
                                    BlocBuilder<UserCubit, UserStates>(
                                      builder: (context, state) {
                                        if (state is getFavouriteSuccessState) {
                                          return Text(
                                              state.movies.data!.length
                                                  .toString(),
                                              style: AppStyles.bold36White);
                                        } else {
                                          return Text("0",
                                              style: AppStyles.bold36White);
                                        }
                                      },
                                    ),
                                    Text('Wish List',
                                        style: AppStyles.bold20White),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                        BrowseTabViewModel.get(context)
                                            .historyList
                                            .length
                                            .toString(),
                                        style: AppStyles.bold36White),
                                    Text('History',
                                        style: AppStyles.bold20White),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: CustomElevatedButton(
                                    buttonText: 'Edit Profile',
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, UpdateProfile.routeName);
                                    },
                                  ),
                                ),
                                SizedBox(width: width * 0.02),
                                Expanded(
                                  child: CustomElevatedButton(
                                    bgColor: AppColors.redColor,
                                    border: BorderSide.none,
                                    buttonWidget: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Exit',
                                            style: AppStyles.regular20White),
                                        SizedBox(width: width * 0.02),
                                        Icon(Icons.logout,
                                            color: AppColors.whiteColor),
                                      ],
                                    ),
                                    buttonText: '',
                                    onPressed: () {
                                      CustomDialog.showAlert(
                                          context: context,
                                          title: 'Exit Account',
                                          message:
                                              'Are you sure you want to exit?',
                                          posActionName: 'Yes',
                                          negActionName: 'No',
                                          posAction: () {
                                            CashHelper.removeData(key: "token");
                                            CashHelper.removeData(
                                                key: "isLoggedIn");
                                            Navigator.pushReplacementNamed(
                                                context, LoginScreen.routeName);
                                          });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                body: TabBarView(
                  children: [
                    BlocBuilder<UserCubit, UserStates>(
                      // bloc: cubit,
                      builder: (context, state) {
                        if (state is getFavouriteSuccessState) {
                          print(getIt<UserCubit>().favoriteMovieList);
                          return state.movies.data!.isEmpty
                              ? Center(
                                  child: Image.asset(AssetsManager.popCornImage,
                                      width: width * 0.25),
                                )
                              : GridView.builder(
                                  padding: EdgeInsets.only(
                                      bottom: height * 0.1,
                                      top: height * 0.02,
                                      left: width * 0.02,
                                      right: width * 0.02),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: width * 0.03,
                                    mainAxisSpacing: height * 0.015,
                                    childAspectRatio: 1 / 1.6,
                                  ),
                                  itemCount: state.movies.data!.length,
                                  itemBuilder: (context, index) {
                                    return MoviePoster(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          DetailsScreen.routeName,
                                          arguments:
                                              state.movies.data![index].movieId,
                                        );
                                      },
                                      networkImage:
                                          state.movies.data![index].imageURL ??
                                              "",
                                      rating: state.movies.data![index].rating
                                          .toString(),
                                      imageWidth: double.infinity,
                                      imageHeight: double.infinity,
                                      imageFit: BoxFit.cover,
                                    );
                                  },
                                );
                        } else if (state is getFavouriteLoadingState) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: AppColors.yellowColor,
                          ));
                        } else if (state is getFavouriteErrorState) {
                          return Center(
                            child: Text(state.errorMsg),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    BrowseTabViewModel.get(context).historyList.isNotEmpty
                        ? GridView.builder(
                            padding: EdgeInsets.only(
                                bottom: height * 0.1,
                          top: height * 0.02,
                          left: width * 0.02,
                          right: width * 0.02),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: width * 0.03,
                        mainAxisSpacing: height * 0.015,
                        childAspectRatio: 1 / 1.6,
                      ),
                            itemCount: BrowseTabViewModel.get(context)
                                .historyList
                                .length,
                            itemBuilder: (context, index) {
                              return MoviePoster(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DetailsScreen.routeName,
                                      arguments: BrowseTabViewModel.get(context)
                                          .historyList[index]
                                          .id);
                                },
                                networkImage: BrowseTabViewModel.get(context)
                                        .historyList[index]
                                        .largeCoverImage ??
                                    BrowseTabViewModel.get(context)
                                        .historyList[index]
                                        .mediumCoverImage ??
                                    BrowseTabViewModel.get(context)
                                        .historyList[index]
                                        .smallCoverImage ??
                                    'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                                rating: BrowseTabViewModel.get(context)
                                    .historyList[index]
                                    .rating
                                    .toString(),
                                imageWidth: double.infinity,
                                imageHeight: double.infinity,
                          imageFit: BoxFit.cover,
                        );
                      },
                          )
                        : Center(
                            child: Image.asset(AssetsManager.popCornImage,
                                width: width * 0.25),
                          ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is GetUserDataLoadingState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.yellowColor,
              ),
            ),
          );
        } else if (state is GetUserDataErrorState) {
          return Scaffold(
            body: Center(
              child: Text(
                state.errorMsg,
                style: AppStyles.regular16Yellow,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
