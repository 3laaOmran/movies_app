import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/ui/auth/login_screen/login_screen.dart';
import 'package:movies_app/ui/auth/register_screen/register_screen.dart';
import 'package:movies_app/ui/details_screen/details_screen.dart';
import 'package:movies_app/ui/home_screen/home_screen.dart';
import 'package:movies_app/ui/home_screen/tabs/browse_tab/cubit/browse_tab_view_model.dart';
import 'package:movies_app/ui/home_screen/tabs/profile/reset_password_screen/reset_password_screen.dart';
import 'package:movies_app/ui/home_screen/tabs/profile/update_profile/update_profile.dart';
import 'package:movies_app/ui/onboarding/onboarding.dart';
import 'package:movies_app/utils/app_theme.dart';
import 'package:movies_app/utils/helpers/cash_helper.dart';
import 'package:movies_app/utils/helpers/my_bloc_observer.dart';
import 'package:path_provider/path_provider.dart';

import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(MovieModelAdapter());
  Hive.registerAdapter(DataAdapter());
  Hive.registerAdapter(MovieAdapter());
  Hive.registerAdapter(TorrentsAdapter());
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => getIt<BrowseTabViewModel>()),
    ],
      child: MoviesApp()));
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});
  @override
  Widget build(BuildContext context) {
    BrowseTabViewModel.get(context).initHive();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: getInitialRoute(),
      routes: {
        DetailsScreen.routeName: (context) => DetailsScreen(),
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
    if (splashScreenFinished != null && isLoggedIn != null ||
        CashHelper.getData(key: 'googleUsername') != null) {
      return HomeScreen.routeName;
    } else if (splashScreenFinished == null) {
      return Onboarding.routeName;
    } else {
      return LoginScreen.routeName;
    }
  }
}
