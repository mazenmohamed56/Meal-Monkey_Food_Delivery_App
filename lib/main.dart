import 'package:flutter/material.dart';
import 'package:meal_monkey/modules/splashScreen/splash_screen.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

void main() {
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
              fontFamily: 'Metropolis-Light',
              fontSize: 30,
              color: primaryFontColor),
          headline2: TextStyle(
              fontFamily: 'Metropolis-Bold',
              fontSize: 14,
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
