import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/cubit.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/states.dart';
import 'package:meal_monkey/modules/HomeScreen/widgets/popular_items_screen.dart';
import 'package:meal_monkey/modules/HomeScreen/widgets/recent_items_screen.dart';
import 'package:meal_monkey/shared/components/constants.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../SearchSCreen/searche_screen.dart';
import '../SearchSCreen/widget/searche_field.dart';
import '../menu-Details-Screen/widgets/food_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () {
            return HomeCubit.get(context).getItems();
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SearchField(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Items',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 22,
                            ),
                      ),
                      InkWell(
                        onTap: () => navigateTo(
                            context,
                            PopularItemsScreen(
                                fav: HomeCubit.get(context).fav)),
                        child: Text(
                          'View All',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: defaultColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 200,
                    child: ListView.separated(
                        //clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => FoodItem(
                              item: HomeCubit.get(context).fav[index],
                              width: 250,
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 15,
                            ),
                        itemCount: HomeCubit.get(context).fav.length < 4
                            ? HomeCubit.get(context).fav.length
                            : 4),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Items',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 22,
                            ),
                      ),
                      InkWell(
                        onTap: () => navigateTo(context, RecentItemsScreen()),
                        child: Text(
                          'View All',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: defaultColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => FoodItem(
                            item: recentItems.isNotEmpty
                                ? recentItems[index]
                                : items[index],
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 15,
                          ),
                      itemCount: recentItems.isNotEmpty
                          ? recentItems.length < 5
                              ? recentItems.length
                              : 5
                          : items.length < 5
                              ? items.length
                              : 5),
                  SizedBox(
                    height: 45,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
