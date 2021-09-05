import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/modules/ResetPasswordScreen/reset_password_screen.dart';
import 'package:meal_monkey/modules/SignUpScreen/sign_up_screen.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 45,
                ),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Add your details to login',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 35,
                ),
                defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: () {},
                    label: 'Your Email',
                    radius: 30),
                const SizedBox(
                  height: 25,
                ),
                defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    validate: () {},
                    label: 'Password',
                    suffix: Icons.remove_red_eye_outlined,
                    isPassword: true,
                    radius: 30),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                    function: () {},
                    text: 'Login',
                    radius: 30,
                    isUpperCase: false),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    navigateTo(context, ResetPasswordScreen());
                  },
                  child: Text(
                    'Forgot your password?',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'or Login With',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 30,
                ),
                defaultButton(
                    function: () {},
                    text: 'Login with Facebook',
                    radius: 30,
                    fontSize: 12,
                    prefix: FontAwesomeIcons.facebookF,
                    fontFamily: 'Metropolis-Medium',
                    backgroundColor: Color(0xFF367FC0),
                    isUpperCase: false),
                const SizedBox(
                  height: 30,
                ),
                defaultButton(
                    function: () {},
                    text: 'Login with Google',
                    radius: 30,
                    fontSize: 12,
                    prefix: FontAwesomeIcons.googlePlusG,
                    fontFamily: 'Metropolis-Medium',
                    backgroundColor: Color(0xFFDD4B39),
                    isUpperCase: false),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an Account?',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    TextButton(
                        onPressed: () {
                          navigateTo(context, SignUpScreen());
                        },
                        child: Text(
                          'Sign Up',
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: mainColor,
                                  ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
