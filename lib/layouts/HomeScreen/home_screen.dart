import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/cubit.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/states.dart';
import 'package:meal_monkey/modules/LoginScreen/login_sreen.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/components/constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserData(),
      child: BlocConsumer<HomeCubit, HomeScreenStates>(
        listener: (context, state) {
          if (state is LogOutSuccessState) {
            navigateAndFinsh(context, LoginScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Container(
                child: defaultButton(
                    function: () {
                      signOut(context);
                    },
                    text: 'LogOut'),
              ),
            ),
          );
        },
      ),
    );
  }
}
