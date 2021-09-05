import 'package:flutter/material.dart';
import 'package:meal_monkey/shared/components/components.dart';

class NewPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
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
                'New Password',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Please enter your email to receive a',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'link to  create a new password via email',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 35,
              ),
              defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  isPassword: true,
                  validate: () {},
                  label: 'New Password',
                  radius: 30),
              const SizedBox(
                height: 25,
              ),
              defaultFormField(
                  controller: emailController,
                  isPassword: true,
                  type: TextInputType.emailAddress,
                  validate: () {},
                  label: 'Confirm Password',
                  radius: 30),
              const SizedBox(
                height: 25,
              ),
              defaultButton(
                  function: () {},
                  text: 'Next',
                  radius: 30,
                  isUpperCase: false),
            ],
          ),
        ),
      ),
    );
  }
}
