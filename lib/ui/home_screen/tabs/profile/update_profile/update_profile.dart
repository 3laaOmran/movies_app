import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/google_signin_api.dart';
import 'package:movies_app/repository/user/repository/user_repository.dart';
import 'package:movies_app/ui/auth/login_screen/login_screen.dart';
import 'package:movies_app/ui/home_screen/tabs/profile/update_profile/show_bottom_sheet.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/asset_manager.dart';
import 'package:movies_app/utils/helpers/cash_helper.dart';

import '../../../../../di/di.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import '../reset_password_screen/reset_password_screen.dart';

class UpdateProfile extends StatefulWidget {
  static const String routeName = 'update_screen';

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var cubit = UserCubit(userRepository: getIt<UserRepository>());

  @override
  void initState() {
    if (CashHelper.getData(key: 'googleUsername') == null) {
      cubit.getUserData();
    } else {
      cubit.getGoogleUserDetails();
      cubit.nameController.text = CashHelper.getData(key: 'googleUsername');
      cubit.googleUserImage = CashHelper.getData(key: 'googleUserImage');
    }
    super.initState();
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
    return BlocProvider(
      create: (context) => cubit,
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is GetUserDataSuccessState) {
            cubit.nameController.text = state.user.name!;
            cubit.phoneController.text = state.user.phone!;
          }
        },
        builder: (context, state) {
          if (state is GetUserDataLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.yellowColor,
              ),
            );
          } else if (state is GetUserDataSuccessState ||
              state is GetGoogleUserDataLoadingState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Pick Avatar"),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.yellowColor,
                  ),
                  onPressed: () {},
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  // Wrap the Column
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () => showAvatarBottomSheet(context),
                        child: Container(
                          width: width * 0.5,
                          height: width * 0.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: state is! GetGoogleUserDataLoadingState
                                  ? AssetImage(avatarList[
                                      state is GetUserDataSuccessState
                                          ? state.user.avaterId!
                                          : 0])
                                  : NetworkImage(cubit.googleUserImage ??
                                      'https://thumbs.dreamstime.com/z/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg?ct=jpeg'),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      TextFormField(
                        controller: cubit.nameController,
                        style: const TextStyle(color: AppColors.whiteColor),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person,
                              color: AppColors.whiteColor),
                          hintText: "Name",
                          hintStyle: const TextStyle(color: Colors.white),
                          fillColor: const Color(0xff282A28),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      TextFormField(
                        controller: cubit.phoneController,
                        style: const TextStyle(color: AppColors.whiteColor),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone,
                              color: AppColors.whiteColor),
                          hintText: "phone",
                          hintStyle:
                              const TextStyle(color: AppColors.whiteColor),
                          fillColor: const Color(0xff282A28),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, ResetPasswordScreen.routeName);
                            },
                            child: const Text(
                              "Reset Password",
                              style: TextStyle(color: AppColors.lightGreyColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.17),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.redColor,
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.02),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () async {
                          if (CashHelper.getData(key: 'googleUsername') ==
                              null) {
                            CashHelper.removeData(key: "token");
                            CashHelper.removeData(key: "isLoggedIn");
                          } else {
                            await GoogleSignInApi.logout();
                            CashHelper.removeData(key: "googleUsername");
                            CashHelper.removeData(key: "googleUserImage");
                          }
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        child: const Text(
                          "Delete Account",
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellowColor,
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.02),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Update Data",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is GetUserDataErrorState) {
            return Text(
              state.errorMsg,
              style: AppStyles.bold20White,
            );
          }
          return Container();
        },
      ),
    );
  }
}
