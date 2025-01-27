import 'package:flutter/material.dart';
import 'package:movies_app/ui/onboarding/onboarding_custom_widget.dart';
import 'package:movies_app/ui/widgets/custom_elevated_button.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../../utils/asset_manager.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  static String routeName = 'onboarding';

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(
      initialPage: 0,
    );
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var screenWidth = 430;
    var screenHeight = 932;
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          //1
          Stack(
            // alignment: Alignment.bottomCenter,
            children: [
              Center(
                child: Image.asset(
                  AssetsManager.onBoarding1,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),

              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * (16 / screenWidth),
                  vertical: height * (33 / screenHeight),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "Find Your Next Favorite Movie Here",
                      style: AppStyles.medium36White,
                    ),
                    SizedBox(
                      height: height * (16 / screenHeight),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Get access to a huge library of movies\n to suit all tastes. You will surely like it.",
                      style: AppStyles.regular20LightGrey,
                    ),
                    SizedBox(
                      height: height * (24 / screenHeight),
                    ),
                    CustomElevatedButton(
                        buttonText: "Explore Now",
                        buttonTextStyle: AppStyles.semiBold20Black,
                        onPressed: () {
                          pageController.animateToPage(1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                          setState(() {});
                        })
                  ],
                ),
              )
            ],
          ),
          //2
          OnboardingCustomWidget(
              onPressedNextButton: () {
                pageController.animateToPage(2,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                setState(() {});
              },
              title: "Discover Movies",
              description: " Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
              button1Text: "Next",
              image: AssetsManager.onBoarding2),
          //3
          OnboardingCustomWidget(
              onPressedBackButton: () {
                pageController.animateToPage(1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                setState(() {});
              },
              onPressedNextButton: () {
                pageController.animateToPage(3,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                setState(() {});
              },
              button2Text: "Back",
              button2BgColor: Colors.transparent,
              description: " Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
              title: "Explore All Genres",
              button1Text: "Next",
              image: AssetsManager.onBoarding3),
          //4
          OnboardingCustomWidget(
              onPressedBackButton: () {
                pageController.animateToPage(2,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                setState(() {});
              },
              onPressedNextButton: () {
                pageController.animateToPage(4,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                setState(() {});
              },
              button2Text: "Back",
              button2BgColor: Colors.transparent,
              description: "Save movies to your watchlist to keep track of what you want to watch next."
                  " Enjoy films in various qualities and genres.",
              title: "Create Watchlists",
              button1Text: "Next",
              image: AssetsManager.onBoarding4),
          //5
          OnboardingCustomWidget(
              onPressedBackButton: () {
                pageController.animateToPage(3,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                setState(() {});
              },
              onPressedNextButton: () {
                pageController.animateToPage(5,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                setState(() {});
              },
              button2Text: "Back",
              button2BgColor: Colors.transparent,
              description: "Save movies to your watchlist to keep track of what you want to watch next."
                  " Enjoy films in various qualities and genres.",
              title: "Create Watchlists",
              button1Text: "Next",
              image: AssetsManager.onBoarding5),
          //6
          OnboardingCustomWidget(
              onPressedBackButton: () {
                pageController.animateToPage(4,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                setState(() {});
              },
              onPressedNextButton: () {
                //todo: navigate to login
              },
              button2Text: "Back",
              button2BgColor: Colors.transparent,
              title: "Start Watching Now",
              button1Text: "Finish",
              image: AssetsManager.onBoarding6),
        ],
      ),
    );
  }
}
