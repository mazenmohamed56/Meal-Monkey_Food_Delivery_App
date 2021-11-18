import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/modules/splashScreen/splash_screen.dart';
import 'package:meal_monkey/shared/BlocObserver.dart';
import 'package:meal_monkey/shared/Network/local/sharedPreferences.dart';
import 'package:meal_monkey/shared/cubit/cubit.dart';
import 'package:meal_monkey/shared/cubit/states.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

import 'layouts/HomeScreen/cubit/cubit.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
            create: (context) => HomeCubit()
              ..getUserData()
              ..getItems()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                headline4: TextStyle(
                    fontFamily: 'Metropolis-SemiBold',
                    fontSize: 14,
                    color: primaryFontColor),
              ),
            ),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
