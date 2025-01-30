import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/custom_elevated_button.dart';
import '../../utils/app_styles.dart';
import '../../utils/asset_manager.dart';
import '../widgets/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName = 'forget_password_screen';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password",
          style: AppStyles.regular16Yellow,),
      ),
      body: Column(
        children: <Widget>[
          Image.asset(AssetsManager.forgetPasswordImage, fit: BoxFit.fill ),
          SizedBox(height:height *.02),
          CustomTextFormField(
            hintText: 'Email',
            controller:TextEditingController(),
            prefixIcon: AssetsManager.emailIcon,
          ) ,

          /*TextFormField(
            style: const TextStyle(color: AppColors.whiteColor),
            decoration: InputDecoration(
              prefixIcon:
              const Icon(Icons.email, color: AppColors.whiteColor),
              hintText: "Email",
              hintStyle: const TextStyle(color: Colors.white),
              fillColor: const Color(0xff282A28),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),*/
          SizedBox(height: height*.02),
          CustomElevatedButton(
              buttonText: 'Verify Email',
              onPressed: (){}
          )

          /*ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.yellowColor,
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Verify Email",
              style: TextStyle(color: Colors.black),
            ),
          ),*/

        ],
      ),

    );
  }
}