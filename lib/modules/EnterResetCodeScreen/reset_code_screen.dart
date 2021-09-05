import 'package:flutter/material.dart';
import 'package:meal_monkey/modules/NewPasswordScreen/new_password_screen.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';
import 'package:pinput/pin_put/pin_put.dart';

class ResetCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var CodeController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 45,
              ),
              Text(
                'We have sent an OTP to',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'your Mobile',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Please check your mobile number 071*****12',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'continue to reset your password',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 35,
              ),
              PinPut(
                preFilledWidget: Text(
                  '*',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 40),
                ),
                withCursor: false,
                fieldsCount: 4,
                eachFieldHeight: 70,
                eachFieldWidth: 70,
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 25),
                submittedFieldDecoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(20)),
                selectedFieldDecoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(20)),
                followingFieldDecoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(20)),
                disabledDecoration: BoxDecoration(color: Colors.black),
                separator: SizedBox(
                  width: 20,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              defaultButton(
                  function: () {
                    navigateTo(context, NewPasswordScreen());
                  },
                  text: 'Next',
                  radius: 30,
                  isUpperCase: false),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t Receive? ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Click Here',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: mainColor,
                            ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
