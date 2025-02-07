import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/widgets/custom_dialog.dart';
import 'package:movies_app/ui/widgets/custom_elevated_button.dart';
import 'package:movies_app/ui/widgets/custom_text_form_field.dart';
import 'package:movies_app/utils/asset_manager.dart';

import '../../../../../di/di.dart';
import '../../../../../utils/app_styles.dart';
import 'cubit/reset_pass_cubit.dart';
import 'cubit/reset_pass_states.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = 'reset_password_screen';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  ResetPassCubit cubit = getIt<ResetPassCubit>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Password",
          style: AppStyles.regular16Yellow,),
      ),
      body: BlocListener(
        bloc: cubit,
        listener: (context, state) {
          if (state is ResetPassLoadingState) {
            CustomDialog.showLoading(context: context, message: "Loading...");
          } else if (state is ResetPassSuccessState) {
            cubit.oldPassController.text = "";
            cubit.newPassController.text = "";
            CustomDialog.hideLoading(context);
            CustomDialog.showAlert(
                context: context, message: state.message, posActionName: "Ok");
          } else if (state is ResetErrorState) {
            CustomDialog.hideLoading(context);
            CustomDialog.showAlert(
                context: context, message: state.errMsg, posActionName: "Ok");
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.025),
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  Image.asset(AssetsManager.forgetPasswordImage,
                      fit: BoxFit.fill),
                  SizedBox(height: height * .02),
                  CustomTextFormField(
                      onSuffixPressed: () {
                        cubit.changeOldPasswordVisibility();
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please Enter Your Old Password";
                        }
                        return null;
                      },
                      prefixIcon: AssetsManager.passwordIcon,
                      keyboardType: TextInputType.visiblePassword,
                      isObscure: cubit.isOldPasswordObscure,
                      suffixIcon: cubit.isOldPasswordObscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      hintText: 'Old Password',
                      controller: cubit.oldPassController),
                  SizedBox(height: height * .02),
                  CustomTextFormField(
                      onSuffixPressed: () {
                        cubit.changeNewPasswordVisibility();
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please Enter Your New Password";
                        }
                        return null;
                      },
                      prefixIcon: AssetsManager.passwordIcon,
                      keyboardType: TextInputType.visiblePassword,
                      isObscure: cubit.isNewPasswordObscure,
                      suffixIcon: cubit.isNewPasswordObscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      hintText: 'Password',
                      controller: cubit.newPassController),
                  SizedBox(height: height * .02),
                  CustomElevatedButton(
                      buttonText: 'Reset Password',
                      onPressed: () {
                        cubit.ChangePass();
                      })
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}