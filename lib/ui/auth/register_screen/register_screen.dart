import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/auth/register_screen/cubit/register_state.dart';
import 'package:movies_app/ui/auth/register_screen/widgets/avatar_slider_widget.dart';
import 'package:movies_app/ui/widgets/ask_user_widget_in_login_register.dart';
import 'package:movies_app/ui/widgets/custom_elevated_button.dart';
import 'package:movies_app/ui/widgets/custom_text_form_field.dart';
import 'package:movies_app/ui/widgets/switch_language_button.dart';
import 'package:movies_app/utils/asset_manager.dart';

import 'cubit/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var cubit = RegisterCubit();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<RegisterCubit, RegisterStates>(
        builder: (context, state) {
          return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.025),
          child: Column(
            children: [
                    AvatarSliderWidget(),
                    Form(
                      key: cubit.formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please Enter Your Name';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                              prefixIcon: AssetsManager.nameIcon,
                              hintText: 'Name',
                              controller: cubit.nameController),
                          SizedBox(height: height * 0.025),
                          CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please Enter Email Address';
                                }
                                final bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value);
                                if (!emailValid) {
                                  return 'Please Enter Valid Email';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: AssetsManager.emailIcon,
                              hintText: 'Email',
                              controller: cubit.emailController),
                          SizedBox(height: height * 0.025),
                          CustomTextFormField(
                              onSuffixPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please Enter Password';
                                }
                                if (value.length <= 6) {
                                  return 'Password must be at least 7 characters';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              isObscure: cubit.isPasswordObscure,
                              suffixIcon: cubit.isPasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              prefixIcon: AssetsManager.passwordIcon,
                              hintText: 'Password',
                              controller: cubit.passwordController),
                          SizedBox(height: height * 0.025),
                          CustomTextFormField(
                              onSuffixPressed: () {
                                cubit.changeRePasswordVisibility();
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please Enter Password Conformation';
                                }
                                if (value != cubit.passwordController.text) {
                                  return 'Password does not match';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              isObscure: cubit.isRePasswordObscure,
                              suffixIcon: cubit.isRePasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              prefixIcon: AssetsManager.passwordIcon,
                              hintText: 'Confirm Password',
                              controller: cubit.rePasswordController),
                          SizedBox(height: height * 0.025),
                          CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please Enter Phone Number';
                                }
                                if (value.length < 11) {
                                  return 'Please Enter Valid Phone Number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.phone,
                              prefixIcon: AssetsManager.phoneIcon,
                              hintText: 'Phone Number',
                              controller: cubit.phoneNumberController),
                          SizedBox(height: height * 0.03),
                          CustomElevatedButton(
                              buttonText: 'Create Account',
                              onPressed: () {
                                cubit.register();
                              }),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
              AskUserWidgetInLoginRegister(
                  question: 'Already Have Account? ',
                  textButtonText: 'Login',
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              SizedBox(height: height * 0.02),
              SwitchLanguageButton(),
                    SizedBox(height: height * 0.025),
                  ],
          ),
        ),
      ),
    );
        },
      ),
    );
  }
}
