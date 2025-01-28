import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/auth/login_screen/login_screen.dart';
import 'package:movies_app/ui/auth/register_screen/register_screen.dart';
import 'package:movies_app/ui/onboarding/onboarding.dart';
import 'package:movies_app/utils/app_theme.dart';
import 'package:movies_app/utils/helpers/cash_helper.dart';
import 'package:movies_app/utils/helpers/my_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
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
      initialRoute: Onboarding.routeName,
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        Onboarding.routeName:(context)=> Onboarding(),
        LoginScreen.routeName:(context)=>LoginScreen(),
      },
    );
  }
}
