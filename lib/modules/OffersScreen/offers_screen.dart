import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/cubit.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/states.dart';
import 'package:meal_monkey/modules/item%20Details%20Screen/item_details_sceen.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class OffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                  itemBuilder: (context, index) =>
                      offerListItem(context, index),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                  itemCount: HomeCubit.get(context).offers.length),
              SizedBox(
                height: 45,
              )
            ],
          ),
        );
      },
    );
  }

  Widget offerListItem(context, index) {
    return InkWell(
      onTap: () {
        navigateTo(
            context, ItemDetailsScreen(HomeCubit.get(context).offers[index]));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
                image: NetworkImage(
                    '${HomeCubit.get(context).offers[index].imagepath}'),
                height: 200,
                width: double.infinity,
                fit: BoxFit.fill),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 21),
              child: Text(
                '${HomeCubit.get(context).offers[index].title}',
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
                  Text('${HomeCubit.get(context).offers[index].rate}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: defaultColor)),
                  const SizedBox(width: 5),
                  Text('( rating)',
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(width: 25),
                  Text('${HomeCubit.get(context).offers[index].category}',
                      style: Theme.of(context).textTheme.bodyText2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
