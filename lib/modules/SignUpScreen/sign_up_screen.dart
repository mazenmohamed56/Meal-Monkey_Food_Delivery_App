import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:meal_monkey/layouts/HomeScreen/home_screen.dart';
import 'package:meal_monkey/modules/LoginScreen/login_sreen.dart';
import 'package:meal_monkey/modules/SignUpScreen/cubit/cubit.dart';
import 'package:meal_monkey/modules/SignUpScreen/cubit/states.dart';
import 'package:meal_monkey/shared/Network/local/sharedPreferences.dart';
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
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterScreenStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            CacheHelper.putData(key: 'uId', value: state.uId);

            navigateAndFinsh(context, HomeScreen());
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);

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
                            validate: (value) {
                              if (value!.isEmpty) {
                                return '         Name must not be empty';
                              }
                            },
                            label: 'name',
                            radius: 30),
                        const SizedBox(
                          height: 25,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return '         Email must not be empty';
                              }
                            },
                            label: 'Email',
                            radius: 30),
                        const SizedBox(
                          height: 25,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return '         Mobile No must not be empty';
                              }
                            },
                            label: 'Mobile No',
                            radius: 30),
                        const SizedBox(
                          height: 25,
                        ),
                        defaultFormField(
                            controller: addressController,
                            type: TextInputType.streetAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return '         Address must not be empty';
                              }
                            },
                            label: 'Address',
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
                            suffix: cubit.suffix,
                            isPassword: cubit.isPassword,
                            suffixPressed: () {
                              cubit.changePasswordVisibilty();
                            },
                            radius: 30),
                        const SizedBox(
                          height: 25,
                        ),
                        defaultFormField(
                            controller: confirmPasswordController,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value != passwordController.text) {
                                return '         Wrong password';
                              }
                            },
                            label: 'Confirm Password',
                            suffix: cubit.suffix,
                            isPassword: cubit.isPassword,
                            suffixPressed: () {
                              cubit.changePasswordVisibilty();
                            },
                            radius: 30),
                        const SizedBox(
                          height: 30,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! RegisterLoadingState,
                          widgetBuilder: (BuildContext context) =>
                              defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      RegisterCubit.get(context).postRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          address: addressController.text);
                                    }
                                  },
                                  text: 'Sign Up',
                                  radius: 30,
                                  isUpperCase: false),
                          fallbackBuilder: (contex) =>
                              Center(child: CircularProgressIndicator()),
                        ),
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
