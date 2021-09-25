import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          buildMoreItem(
              context, 'Payment Details', FontAwesomeIcons.handHoldingUsd),
          const SizedBox(
            height: 15,
          ),
          buildMoreItem(context, 'My Orders', FontAwesomeIcons.shoppingBag),
          const SizedBox(
            height: 15,
          ),
          buildMoreItem(context, 'Notifications', FontAwesomeIcons.solidBell),
          const SizedBox(
            height: 15,
          ),
          buildMoreItem(context, 'Inbox', FontAwesomeIcons.envelope),
          const SizedBox(
            height: 15,
          ),
          buildMoreItem(context, 'About Us', FontAwesomeIcons.info),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  Widget buildMoreItem(BuildContext context, String title, IconData icon) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {},
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
                  color: Color(0xFFE9E9E9),
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
                  color: Color(0xFFE9E9E9),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(FontAwesomeIcons.chevronRight,
                      size: 20, color: placeholder),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
