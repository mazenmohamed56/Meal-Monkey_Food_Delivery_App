import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/cubit.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/states.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/cubit/cubit.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class HomeLayOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getUserData()
        ..getItems(),
      child: BlocConsumer<HomeCubit, HomeScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: AppBar(
                    elevation: 0,
                    title: Text(
                      cubit.titles[cubit.currentIndex],
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    actions: [
                      themIcon(context: context),
                      cartIcon(context: context)
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
                    FontAwesomeIcons.house,
                    size: 40,
                    color: Theme.of(context).scaffoldBackgroundColor,
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
                color: AppCubit.get(context).isDark
                    ? Color.fromARGB(255, 23, 25, 43)
                    : Color(0xFFffffff),
                notchMargin: 5,
                elevation: 30,
                child: Container(
                  color: Colors.transparent,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          btmbatItem(cubit, context,
                              FontAwesomeIcons.tableCellsLarge, 'Menu', 0),
                          btmbatItem(cubit, context,
                              FontAwesomeIcons.bagShopping, 'Offerss', 1),
                        ],
                      ),
                      // Right Tab bar icons
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          btmbatItem(cubit, context, FontAwesomeIcons.user,
                              'Profile', 2),
                          btmbatItem(cubit, context, Icons.read_more_outlined,
                              'More', 3),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              body: cubit.screens[cubit.currentIndex],
            ),
          );
        },
      ),
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
