import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/cubit.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/states.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class HomeLayOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserData(),
      child: BlocConsumer<HomeCubit, HomeScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xFFffffff),
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: Theme.of(context).textTheme.headline3,
              ),
              actionsIconTheme: IconThemeData(color: primaryFontColor),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    FontAwesomeIcons.shoppingCart,
                    size: 25,
                  ),
                )
              ],
            ),
            floatingActionButton: MaterialButton(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightElevation: 0,
              hoverElevation: 0,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: cubit.currentIndex == 4 ? defaultColor : placeholder,
                ),
                child: Icon(
                  FontAwesomeIcons.home,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                cubit.changeBottomNav(4, context);
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 8,
              elevation: 10,
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MaterialButton(
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          minWidth: 40,
                          onPressed: () {
                            cubit.changeBottomNav(0, context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.thLarge,
                                color: cubit.currentIndex == 0
                                    ? defaultColor
                                    : placeholder,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Menu',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: cubit.currentIndex == 0
                                          ? defaultColor
                                          : secondaryFontColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          minWidth: 40,
                          onPressed: () {
                            cubit.changeBottomNav(1, context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.shoppingBag,
                                color: cubit.currentIndex == 1
                                    ? defaultColor
                                    : placeholder,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Offers',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: cubit.currentIndex == 1
                                          ? defaultColor
                                          : secondaryFontColor,
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    // Right Tab bar icons

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          minWidth: 40,
                          onPressed: () {
                            cubit.changeBottomNav(2, context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.user,
                                  color: cubit.currentIndex == 2
                                      ? defaultColor
                                      : placeholder),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Profile',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: cubit.currentIndex == 2
                                          ? defaultColor
                                          : secondaryFontColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          minWidth: 40,
                          onPressed: () {
                            cubit.changeBottomNav(3, context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.read_more_outlined,
                                color: cubit.currentIndex == 3
                                    ? defaultColor
                                    : placeholder,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'More',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: cubit.currentIndex == 3
                                          ? defaultColor
                                          : secondaryFontColor,
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
