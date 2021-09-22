import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/modules/splashScreen/splash_screen.dart';
import 'package:meal_monkey/shared/BlocObserver.dart';
import 'package:meal_monkey/shared/Network/local/sharedPreferences.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFffffff),
        primarySwatch: Colors.deepOrange,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Metropolis-Medium',
            fontSize: 14.0,
            color: secondaryFontColor,
          ),
          headline1: TextStyle(
              fontFamily: 'Metropolis-ExtraBold',
              fontSize: 30,
              color: primaryFontColor),
          headline2: TextStyle(
              fontFamily: 'Metropolis-Bold',
              fontSize: 16,
              color: primaryFontColor),
          headline3: TextStyle(
              fontFamily: 'Metropolis-Light',
              fontSize: 30,
              color: primaryFontColor),
          bodyText2: TextStyle(
              fontFamily: 'Metropolis-Regular',
              fontSize: 14,
              color: secondaryFontColor),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
