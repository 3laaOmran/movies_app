import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/ask_user_widget_in_login_register.dart';
import 'package:movies_app/ui/widgets/custom_elevated_button.dart';
import 'package:movies_app/ui/widgets/custom_text_form_field.dart';
import 'package:movies_app/ui/widgets/switch_language_button.dart';
import 'package:movies_app/utils/asset_manager.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.025),
          child: Column(
            children: [
              CustomTextFormField(
                  prefixIcon: AssetsManager.nameIcon,
                  hintText: 'Name',
                  controller: nameController),
              SizedBox(height: height * 0.025),
              CustomTextFormField(
                  prefixIcon: AssetsManager.emailIcon,
                  hintText: 'Email',
                  controller: emailController),
              SizedBox(height: height * 0.025),
              CustomTextFormField(
                  prefixIcon: AssetsManager.passwordIcon,
                  hintText: 'Password',
                  controller: passwordController),
              SizedBox(height: height * 0.025),
              CustomTextFormField(
                  prefixIcon: AssetsManager.passwordIcon,
                  hintText: 'Confirm Password',
                  controller: rePasswordController),
              SizedBox(height: height * 0.025),
              CustomTextFormField(
                  prefixIcon: AssetsManager.phoneIcon,
                  hintText: 'Phone Number',
                  controller: phoneNumberController),
              SizedBox(height: height * 0.03),
              CustomElevatedButton(
                  buttonText: 'Create Account', onPressed: () {}),
              SizedBox(height: height * 0.02),
              AskUserWidgetInLoginRegister(
                  question: 'Already Have Account? ',
                  textButtonText: 'Login',
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              SizedBox(height: height * 0.02),
              SwitchLanguageButton(),
            ],
          ),
        ),
      ),
    );
  }
}
