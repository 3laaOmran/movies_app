import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/auth/forget_password_screen/forget_pasword_screen.dart';
import 'package:movies_app/ui/auth/login_screen/login_screen.dart';
import 'package:movies_app/ui/auth/register_screen/register_screen.dart';
import 'package:movies_app/ui/onboarding/onboarding.dart';
import 'package:movies_app/ui/tabs/home_tab/home_tab.dart';
import 'package:movies_app/ui/tabs/profile/update_profile/update_profile.dart';
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
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
        HomeTab.routeName: (context) => HomeTab(),
        UpdateProfile.routeName: (context) => UpdateProfile(),
      },
    );
  }

  String getInitialRoute() {
    var isLoggedIn = CashHelper.getData(key: "isLoggedIn");
    var splashScreenFinished = CashHelper.getData(key: "splashScreenFinished");
    if (splashScreenFinished != null && isLoggedIn != null) {
      return HomeTab.routeName;
    } else if (splashScreenFinished == null) {
      return Onboarding.routeName;
    } else {
      return LoginScreen.routeName;
    }
  }
}
