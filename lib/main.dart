import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/shared/styles/Themes.dart';

import 'modules/CartScreen/cubit/cubit.dart';
import 'modules/MapScreen/cubit/cubit.dart';
import 'modules/splashScreen/splash_screen.dart';
import 'shared/BlocObserver.dart';
import 'shared/Network/local/sharedPreferences.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();

  bool? isDark = CacheHelper.getData(key: 'isDark');
  print(isDark);
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(isDark ?? false));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..changeThemeMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => CartScreenCubit()..getdata(),
        ),
        BlocProvider(
          create: (BuildContext context) => MapScreenCubit()
            ..clearAddressMarkerList()
            ..getUserAddressPosition(context),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lighTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
