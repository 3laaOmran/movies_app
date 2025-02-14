import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/repository/user/repository/user_repository.dart';
import 'package:movies_app/ui/auth/login_screen/login_screen.dart';
import 'package:movies_app/ui/home_screen/tabs/profile/update_profile/show_bottom_sheet.dart';
import 'package:movies_app/ui/widgets/custom_dialog.dart';
import 'package:movies_app/ui/widgets/custom_elevated_button.dart';
import 'package:movies_app/ui/widgets/custom_text_form_field.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/asset_manager.dart';
import 'package:movies_app/utils/helpers/cash_helper.dart';

import '../../../../../api/google_signin_api.dart';
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
  UserCubit cubit = UserCubit(userRepository: getIt<UserRepository>());

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

    return BlocConsumer<UserCubit, UserStates>(
      bloc: cubit,
      listener: (context, state) {
        if (state is GetUserDataSuccessState) {
          cubit.nameController.text = state.user.name ?? "";
          cubit.phoneController.text = state.user.phone ?? "";
          cubit.selectedAvatarId = (state.user.avaterId ?? 0).clamp(0, avatarList.length - 1);
        }
        if (state is UpdateUserDataSuccessState) {
          CustomDialog.hideLoading(context);
          CustomDialog.showAlert(
              context: context,
              title: 'Success',
              message: state.updateProfileModel.message ?? '',
              posActionName: 'Ok',
              posAction: () {
                cubit.getUserData();
          });
        } else if (state is UpdateUserDataErrorState) {
          CustomDialog.hideLoading(context);
          CustomDialog.showAlert(
              context: context,
              title: 'Error',
              message: state.errorMsg,
              posActionName: 'ok');
        } else if (state is UpdateUserDataLoadingState) {
          CustomDialog.showLoading(context: context, message: 'Updating...');
        }
        if (state is DeleteAccountSuccessState) {
          CustomDialog.hideLoading(context);
          CustomDialog.showAlert(
              context: context,
              message: 'Account deleted successfully.',
              posActionName: 'Ok',
              posAction: () async {
                if (CashHelper.getData(key: 'googleUsername') == null) {
                  CashHelper.removeData(key: "token");
                  CashHelper.removeData(key: "isLoggedIn");
                } else {
                  await GoogleSignInApi.logout();
                  CashHelper.removeData(key: "googleUsername");
                  CashHelper.removeData(key: "googleUserImage");
                }
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          });
        } else if (state is DeleteAccountErrorState) {
          CustomDialog.hideLoading(context);
          CustomDialog.showAlert(context: context, message: state.errorMsg, posActionName: 'Ok');
        } else if (state is DeleteAccountLoadingState) {
          CustomDialog.showLoading(context: context, message: 'Deleting account...');
        }
      },
      builder: (context,state){
        if(state is GetUserDataLoadingState){
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.yellowColor,
              ),
          ));
        } else if (state is GetUserDataErrorState) {
          return Scaffold(
            body: Center(
                child: Text(state.errorMsg,style: AppStyles.bold24White,)
            ),
          );
        } else if (state is GetUserDataSuccessState ||
            state is GetGoogleUserDataLoadingState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Update Profile"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Avatar Selection
                    GestureDetector(
                      onTap: () => showAvatarBottomSheet(context, (selectedAvatarId) {
                        setState(() {
                          cubit.selectedAvatarId = selectedAvatarId;
                        });
                        cubit.updateAvatar(selectedAvatarId);
                      }),
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
                                    'https://img.freepik.com/premium-vector/vector-flat-illustration-grayscale-avatar-user-profile-person-icon-profile-picture-business-profile-woman-suitable-social-media-profiles-icons-screensavers-as-templatex9_719432-1351.jpg?ga=GA1.1.1564111303.1739032657&semt=ais_hybrid'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextFormField(
                      hintText: 'Name',
                      prefixIcon: AssetsManager.profileIcon,
                      controller: cubit.nameController,
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextFormField(
                      hintText: 'Phone',
                      prefixIcon: AssetsManager.phoneIcon,
                      controller: cubit.phoneController,
                    ),
                    SizedBox(height: height * 0.015),
                    // Reset Password Button
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
                    SizedBox(height: height * 0.15),

                    //TODO: Delete Account Button
                    CustomElevatedButton(
                      buttonText: 'Delete Account',
                      onPressed: () async {
                        CustomDialog.showAlert(
                          context: context,
                          message: 'Are you sure you want to delete your account?',
                          title: 'Delete Account',
                          negActionName: 'Delete',
                          negAction: () async {
                            cubit.deleteAccount();
                          },
                          posActionName: 'Cancel',
                        );
                      },
                      bgColor: AppColors.redColor,
                      border: BorderSide.none,
                      buttonTextStyle: AppStyles.regular20White,
                    ),
                    SizedBox(height: height * 0.02),

                    // Update Data Button
                    CustomElevatedButton(
                      buttonText: 'Update Data',
                      onPressed: () {
                        if (cubit.nameController.text.trim().isEmpty ||
                            cubit.phoneController.text.trim().isEmpty) {
                          CustomDialog.showAlert(
                              context: context,
                              title: 'Error',
                              message: 'Fields cannot be empty',
                              posActionName: 'Ok');
                          return;
                        }

                        cubit.updateUserData(
                          name: cubit.nameController.text.trim(),
                          phone: cubit.phoneController.text.trim(),
                          avatarId: cubit.selectedAvatarId,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
