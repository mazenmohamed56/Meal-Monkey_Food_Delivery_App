import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/cubit.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/states.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class HomeLayOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: AppBar(
                elevation: 0,
                backgroundColor: Color(0xFFffffff),
                title: Text(
                  cubit.titles[cubit.currentIndex],
                  style: Theme.of(context).textTheme.headline3,
                ),
                actionsIconTheme: IconThemeData(color: primaryFontColor),
                actions: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 20.0),
                    child: Icon(
                      FontAwesomeIcons.shoppingCart,
                      size: 25,
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: MaterialButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightElevation: 0,
            hoverElevation: 0,
            child: Container(
              width: 73,
              height: 73,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: cubit.currentIndex == 4 ? defaultColor : placeholder,
              ),
              child: Icon(
                FontAwesomeIcons.home,
                size: 40,
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
            notchMargin: 5,
            elevation: 20,
            child: Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      btmbatItem(
                          cubit, context, FontAwesomeIcons.thLarge, 'Menu', 0),
                      btmbatItem(cubit, context, FontAwesomeIcons.shoppingBag,
                          'Offerss', 1),
                    ],
                  ),
                  // Right Tab bar icons
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      btmbatItem(
                          cubit, context, FontAwesomeIcons.user, 'Profile', 2),
                      btmbatItem(
                          cubit, context, Icons.read_more_outlined, 'More', 3),
                    ],
                  )
                ],
              ),
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }

  Widget btmbatItem(HomeCubit cubit, BuildContext context, IconData icon,
      String title, int index) {
    return MaterialButton(
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      minWidth: 40,
      onPressed: () {
        cubit.changeBottomNav(index, context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: cubit.currentIndex == index ? defaultColor : placeholder,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '$title',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: cubit.currentIndex == index
                      ? defaultColor
                      : secondaryFontColor,
                ),
          ),
        ],
      ),
    );
  }
}
