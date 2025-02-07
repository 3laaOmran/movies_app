import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/auth/login_screen/login_screen.dart';
import 'package:movies_app/ui/auth/register_screen/register_screen.dart';
import 'package:movies_app/ui/home_screen/home_screen.dart';
import 'package:movies_app/ui/home_screen/tabs/profile/reset_password_screen/reset_password_screen.dart';
import 'package:movies_app/ui/home_screen/tabs/profile/update_profile/update_profile.dart';
import 'package:movies_app/ui/onboarding/onboarding.dart';
import 'package:movies_app/utils/app_theme.dart';
import 'package:movies_app/utils/helpers/cash_helper.dart';
import 'package:movies_app/utils/helpers/my_bloc_observer.dart';

import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: getInitialRoute(),
      routes: {
        Onboarding.routeName:(context)=> Onboarding(),
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
        UpdateProfile.routeName: (context) => UpdateProfile(),
      },
    );
  }

  String getInitialRoute() {
    var isLoggedIn = CashHelper.getData(key: "isLoggedIn");
    var splashScreenFinished = CashHelper.getData(key: "splashScreenFinished");
    if (splashScreenFinished != null && isLoggedIn != null) {
      return HomeScreen.routeName;
    } else if (splashScreenFinished == null) {
      return Onboarding.routeName;
    } else {
      return LoginScreen.routeName;
    }
  }
}
