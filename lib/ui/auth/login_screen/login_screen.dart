import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/google_signin_api.dart';
import 'package:movies_app/ui/auth/login_screen/cubit/login_cubit.dart';
import 'package:movies_app/ui/auth/register_screen/register_screen.dart';
import 'package:movies_app/ui/home_screen/home_screen.dart';
import 'package:movies_app/ui/widgets/ask_user_widget_in_login_register.dart';
import 'package:movies_app/ui/widgets/custom_elevated_button.dart';
import 'package:movies_app/ui/widgets/switch_language_button.dart';
import 'package:movies_app/utils/asset_manager.dart';
import 'package:movies_app/utils/helpers/cash_helper.dart';

import '../../../di/di.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/custom_text_form_field.dart';
import 'cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login_screen';

  LoginCubit cubit = getIt<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (context) => cubit,
        child: BlocConsumer(
          bloc: cubit,
          listener: (context, state) {
            if (state is LoginLoadingState) {
              CustomDialog.showLoading(context: context, message: 'Loading...');
            } else if (state is LoginErrorState) {
              CustomDialog.hideLoading(context);
              CustomDialog.showAlert(
                title: "Error",
                context: context,
                message: state.errorMessage,
                posActionName: 'Ok',
              );
            } else if (state is LoginSuccessState) {
              CustomDialog.hideLoading(context);
              CustomDialog.showAlert(
                  context: context,
                  title: 'Success',
                  message: state.message,
                  posActionName: 'Ok',
                  posAction: () {
                    Navigator.pushReplacementNamed(
                        context, HomeScreen.routeName);
                  });
            }
          },
          builder: (context, state) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: AppColors.blackColor,
              body: SingleChildScrollView(
                child: Form(
                    key: cubit.formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.030),
                      child: Column(
                        children: [
                          Image.asset(
                            AssetsManager.appIcon,
                            height: height * 0.35,
                          ),
                          CustomTextFormField(
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please Enter Your Email Address';
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);
                              if (!emailValid) {
                                return 'Please Enter Valid Email';
                              }
                              return null;
                            },
                            controller: cubit.emailController,
                            prefixIcon: AssetsManager.emailIcon,
                            hintText: 'Email',
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          CustomTextFormField(
                              onSuffixPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please Enter Your Password";
                                }
                                return null;
                              },
                              prefixIcon: AssetsManager.passwordIcon,
                              keyboardType: TextInputType.visiblePassword,
                              isObscure: cubit.isPasswordObscure,
                              suffixIcon: cubit.isPasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              hintText: 'Password',
                              controller: cubit.passwordController),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // TODO: Navigate to forget password screen.
                                  },
                                  child: Text(
                                    'Forget Password ?',
                                    style: AppStyles.regular14Yellow, //
                                  ),
                                ),
                              ]),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          CustomElevatedButton(
                              buttonText: 'Login',
                              onPressed: () {
                                cubit.login();
                              }),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          AskUserWidgetInLoginRegister(
                              question: 'Don\'t Have Account ?',
                              textButtonText: ' Create one',
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.routeName);
                              }),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1.5,
                                  color: AppColors.yellowColor,
                                  indent: 65,
                                  endIndent: 20,
                                ),
                              ),
                              Text(
                                'OR',
                                style: AppStyles.regular16Yellow,
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1.5,
                                  indent: 20,
                                  endIndent: 60,
                                  color: AppColors.yellowColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          CustomElevatedButton(
                            onPressed: () async {
                              final user = await GoogleSignInApi.Login();
                              if (user != null) {
                                CashHelper.saveData(
                                    key: 'googleUsername',
                                    value: user.displayName);
                                CashHelper.saveData(
                                    key: 'googleUserImage',
                                    value: user.photoUrl ??
                                        'https://img.freepik.com/premium-vector/vector-flat-illustration-grayscale-avatar-user-profile-person-icon-profile-picture-business-profile-woman-suitable-social-media-profiles-icons-screensavers-as-templatex9_719432-1351.jpg?ga=GA1.1.1564111303.1739032657&semt=ais_hybrid');
                                Navigator.pushReplacementNamed(
                                    context, HomeScreen.routeName);
                              }
                            },
                            buttonText: '',
                            buttonWidget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AssetsManager.googleIcon),
                                SizedBox(
                                  width: width * 0.03,
                                ),
                                Text('Login With Google',
                                    style: AppStyles.regular16Black),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          SwitchLanguageButton()
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ));
  }
}
