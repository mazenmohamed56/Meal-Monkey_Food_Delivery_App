import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meal_monkey/modules/StartScreen/start_screen.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => navigateAndFinsh(context, StartScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            width: double.infinity,
            image: AssetImage('assets/images/SplashBackGround.jpeg'),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/Monkey face.png'),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Meal ',
                    style: TextStyle(
                      fontSize: 40,
                      color: mainColor,
                      fontFamily: 'Cabin-Bold',
                    ),
                  ),
                  Text('Monkey',
                      style: TextStyle(
                          fontSize: 40,
                          color: primaryFontColor,
                          fontFamily: 'Cabin-Bold'))
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text('FOOD DELIVERY',
                  style: Theme.of(context).textTheme.bodyText2),
            ],
          ),
        ],
      ),
    );
  }
}
