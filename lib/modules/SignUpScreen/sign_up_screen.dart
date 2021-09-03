import 'package:flutter/material.dart';
import 'package:meal_monkey/modules/LoginScreen/login_sreen.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var addressController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
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
                  'Sign Up',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Add your details to Sign Up',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 35,
                ),
                defaultFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    validate: () {},
                    label: 'name',
                    radius: 30),
                const SizedBox(
                  height: 25,
                ),
                defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: () {},
                    label: 'Email',
                    radius: 30),
                const SizedBox(
                  height: 25,
                ),
                defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: () {},
                    label: 'Mobile No',
                    radius: 30),
                const SizedBox(
                  height: 25,
                ),
                defaultFormField(
                    controller: addressController,
                    type: TextInputType.streetAddress,
                    validate: () {},
                    label: 'Address',
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
                  height: 25,
                ),
                defaultFormField(
                    controller: confirmPasswordController,
                    type: TextInputType.visiblePassword,
                    validate: () {},
                    label: 'Confirm Password',
                    suffix: Icons.remove_red_eye_outlined,
                    isPassword: true,
                    radius: 30),
                const SizedBox(
                  height: 30,
                ),
                defaultButton(
                    function: () {},
                    text: 'Sign Up',
                    radius: 30,
                    isUpperCase: false),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an Account?',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    TextButton(
                        onPressed: () {
                          navigateTo(context, LoginScreen());
                        },
                        child: Text(
                          'Login',
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
