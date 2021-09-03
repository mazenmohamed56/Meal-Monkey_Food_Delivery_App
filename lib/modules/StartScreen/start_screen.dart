import 'package:flutter/material.dart';
import 'package:meal_monkey/modules/LoginScreen/login_sreen.dart';
import 'package:meal_monkey/modules/SignUpScreen/sign_up_screen.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

import 'cuastom-painter.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 450,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: CustomPaint(
                              size: Size(double.infinity, 500),
                              painter: RPSCustomPainter(
                                  Color(0xB60A0808).withOpacity(0.04)),
                            ),
                          ),
                          CustomPaint(
                            size: Size(double.infinity, 400),
                            painter: RPSCustomPainter(
                                Color(0xfffc6414).withOpacity(1.0)),
                          ),
                          CustomPaint(
                            size: Size(double.infinity, 400),
                            painter: RPSCustomPainter(
                                Color(0x872E2828).withOpacity(0.3)),
                          ),
                          Image(
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                                'assets/images/background objects.png'),
                          ),
                        ],
                      )),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        AssetImage('assets/images/Monkey face.png'),
                  )
                ],
              ),
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
            Text('FOOD DELIVERY', style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Discover the best foods from over 1,000',
                      style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('restaurants and fast delivery to your doorstep',
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: defaultButton(
                  function: () {
                    navigateTo(context, LoginScreen());
                  },
                  text: 'Login',
                  radius: 30,
                  isUpperCase: false),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: defaultButton(
                  function: () {
                    navigateTo(context, SignUpScreen());
                  },
                  text: 'Create an Account',
                  radius: 30,
                  isUpperCase: false,
                  fontColor: mainColor,
                  borderWidth: 1,
                  backgroundColor: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
