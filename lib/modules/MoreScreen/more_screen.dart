import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/modules/MyOrders/my_orders.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/cubit/cubit.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            buildMoreItem(context, 'Payment Details',
                FontAwesomeIcons.handHoldingDollar, () {}),
            const SizedBox(
              height: 15,
            ),
            buildMoreItem(context, 'My Orders', FontAwesomeIcons.bagShopping,
                () {
              navigateTo(context, MyOrders());
            }),
            const SizedBox(
              height: 15,
            ),
            buildMoreItem(
                context, 'Notifications', FontAwesomeIcons.solidBell, () {}),
            const SizedBox(
              height: 15,
            ),
            buildMoreItem(context, 'Inbox', FontAwesomeIcons.envelope, () {}),
            const SizedBox(
              height: 15,
            ),
            buildMoreItem(context, 'About Us', FontAwesomeIcons.info, () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  builder: (BuildContext context) => Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'About Us :',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 15),
                                  child: Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud ',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
            }),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMoreItem(BuildContext context, String title, IconData icon,
      VoidCallback function) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: function,
      child: Container(
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Container(
                height: 75,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppCubit.get(context).isDark
                      ? Color.fromARGB(255, 33, 40, 55)
                      : Color(0xFFE9E9E9),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        width: 53,
                        height: 53,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xFFB4B3B3),
                        ),
                        child: Icon(
                          icon,
                          size: 28,
                          color: primaryFontColor,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '$title',
                        style: Theme.of(context).textTheme.headline4,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Container(
                width: 33,
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppCubit.get(context).isDark
                      ? Color.fromARGB(255, 33, 40, 55)
                      : Color(0xFFE9E9E9),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(FontAwesomeIcons.chevronRight,
                      size: 20, color: defaultColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
