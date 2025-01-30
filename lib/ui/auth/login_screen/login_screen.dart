import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/auth/forget_password_screen/forget_pasword_screen.dart';
import 'package:movies_app/ui/auth/login_screen/cubit/login_cubit.dart';
import 'package:movies_app/ui/auth/register_screen/register_screen.dart';
import 'package:movies_app/ui/profile/update_profile/update_profile.dart';
import 'package:movies_app/ui/widgets/ask_user_widget_in_login_register.dart';
import 'package:movies_app/ui/widgets/custom_elevated_button.dart';
import 'package:movies_app/ui/widgets/switch_language_button.dart';
import 'package:movies_app/utils/asset_manager.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../widgets/custom_text_form_field.dart';
import 'cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
static const String routeName='login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginCubit cubit=LoginCubit();
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (context)=>cubit,
        child: BlocBuilder<LoginCubit,LoginStates>(
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: AppColors.blackColor,
              body: SingleChildScrollView(
                child: Form(
                    key: cubit.formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width*0.030
                      ),
                      child: Column(
                        children: [
                      Image.asset(
                        AssetsManager.appIcon,
                      height: height*0.35,),
                      CustomTextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value){
                          if(value==null|| value.trim().isEmpty){
                            return 'Please Enter Your Email Address';
                          }
                          bool emailValid=RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                          if(!emailValid){
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                        controller: cubit.emailController,
                        prefixIcon: AssetsManager.emailIcon,
                        hintText: 'Email',
                      ),
                      SizedBox(height: height*0.02,),
                      CustomTextFormField(
                          onSuffixPressed: (){
                            cubit.changePasswordVisibility();
                          },
                          validator: (value){
                            if(value==null|| value.trim().isEmpty){
                              return "Please Enter Your Password";
                            }
                            if(value.length <=6){
                              return 'Password must be at least 7 characters';
                            }
                            return null;
                          } ,
                          prefixIcon:  AssetsManager.passwordIcon,
                          keyboardType: TextInputType.visiblePassword,
                          isObscure: cubit.isPasswordObscure,
                          suffixIcon: cubit.isPasswordObscure?
                          Icons.visibility_off:
                          Icons.visibility,
                          hintText: 'Password',
                          controller: cubit.passwordController),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[ TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, ForgetPasswordScreen.routeName);
                                },
                                child: Text('Forget Password ?',style: AppStyles.regular14Yellow, //
                                ),),
                              ]
                          ),
                          SizedBox(height: height*0.020,),
                          CustomElevatedButton(
                              buttonText: 'Login',
                              onPressed: (){
                                cubit.login();
                              }),
                          SizedBox(height: height*0.03,),
                          AskUserWidgetInLoginRegister(
                              question: 'Don\'t Have Account ?',
                              textButtonText: ' Create one',
                              onPressed: (){
                                Navigator.of(context).pushNamed(RegisterScreen.routeName);
                              }),
                          SizedBox(height: height*0.04,),
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
                              Text('OR',style: AppStyles.regular16Yellow,),
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
                          SizedBox(height: height*0.03,),
                          CustomElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, UpdateProfile.routeName);
                          },
                          buttonText: '',
                              buttonWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Image.asset(AssetsManager.googleIcon),
                                  SizedBox(width: width*0.03,),
                                  Text('Login With Google',style: AppStyles.regular16Black),
                                  ],
                          ),
                          ),
                          SizedBox(height: height*0.03,),
                          SwitchLanguageButton()
                        ],
                      ),
                    )),
              ),
            ),
          );
        }
    ),
    );
  }
}
