import 'package:flutter/material.dart';
import 'package:movies_app/ui/tabs/profile/update_profile/show_bottom_sheet.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/asset_manager.dart';

class UpdateProfile extends StatelessWidget {
  static const String routeName = 'update_screen';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(AssetsManager.avatar1),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              TextFormField(
                style: const TextStyle(color: AppColors.whiteColor),
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.person, color: AppColors.whiteColor),
                  hintText: "John Safwat",
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
              ),
              SizedBox(height: height * 0.01),
              TextFormField(
                style: const TextStyle(color: AppColors.whiteColor),
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.phone, color: AppColors.whiteColor),
                  hintText: "01200000000",
                  hintStyle: const TextStyle(color: AppColors.whiteColor),
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
                    onPressed: () {},
                    child: const Text(
                      "Reset Password",
                      style: TextStyle(color: AppColors.lightGreyColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.redColor,
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Delete Account",
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
              SizedBox(height: height * 0.02),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellowColor,
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
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
  }
}
