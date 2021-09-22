import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/layouts/HomeScreen/home_layout.dart';
import 'package:meal_monkey/modules/BoardingScreen/boarding_screen.dart';
import 'package:meal_monkey/modules/LoginScreen/cubit/cubit.dart';
import 'package:meal_monkey/modules/LoginScreen/cubit/states.dart';
import 'package:meal_monkey/modules/ResetPasswordScreen/reset_password_screen.dart';
import 'package:meal_monkey/modules/SignUpScreen/sign_up_screen.dart';
import 'package:meal_monkey/shared/Network/local/sharedPreferences.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginScreenStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.putData(key: 'uId', value: state.uId);
            late Widget widget;
            if (CacheHelper.getData(key: 'isOnBoarding') == null) {
              widget = BoardingScreen();
            } else
              widget = HomeLayOut();

            navigateAndFinsh(context, widget);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: formKey,
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
                            validate: (value) {
                              if (value!.isEmpty) {
                                return '         Email must not be empty';
                              }
                            },
                            label: 'Your Email',
                            radius: 30),
                        const SizedBox(
                          height: 25,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.length < 6) {
                                return '         Password is to short must be 6 digit or more';
                              }
                            },
                            label: 'Password',
                            suffix: LoginCubit.get(context).suffix,
                            isPassword: LoginCubit.get(context).isPassword,
                            suffixPressed: () {
                              LoginCubit.get(context).changePasswordVisibilty();
                            },
                            radius: 30),
                        const SizedBox(
                          height: 20,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! LoginLoadingState,
                          widgetBuilder: (BuildContext context) =>
                              defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  text: 'Login',
                                  radius: 30,
                                  isUpperCase: false),
                          fallbackBuilder: (contex) =>
                              Center(child: CircularProgressIndicator()),
                        ),
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
                            function: () {
                              LoginCubit.get(context).fbSignIn();
                            },
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
                            function: () {
                              LoginCubit.get(context).googleSignIn();
                            },
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
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
            ),
          );
        },
      ),
    );
  }
}
