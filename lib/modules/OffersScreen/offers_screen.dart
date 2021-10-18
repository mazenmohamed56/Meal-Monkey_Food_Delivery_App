import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class OffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 21, end: 120),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Find discounts Offers special meals',
                      style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 40.0),
                    child: defaultButton(
                        function: (e) {},
                        text: 'Check Offers',
                        radius: 30,
                        height: 35,
                        isUpperCase: false),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => offerListItem(context),
              separatorBuilder: (context, index) => SizedBox(
                    height: 15,
                  ),
              itemCount: 6),
          SizedBox(
            height: 45,
          )
        ],
      ),
    );
  }

  Widget offerListItem(context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
              image: AssetImage(
                  'assets/images/guy-basabose-FzdEbrA3Qj0-unsplash.jpg'),
              height: 200,
              width: double.infinity,
              fit: BoxFit.fill),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 21),
            child: Text(
              'Coffe',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 21),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  FontAwesomeIcons.solidStar,
                  color: defaultColor,
                  size: 14,
                ),
                const SizedBox(width: 5),
                Text('4.9',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: defaultColor)),
                const SizedBox(width: 5),
                Text('(120 rating)',
                    style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(width: 25),
                Text('Beverages', style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          )
        ],
      ),
    );
  }
}
