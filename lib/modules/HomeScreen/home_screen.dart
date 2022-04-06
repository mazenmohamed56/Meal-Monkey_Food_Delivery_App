import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/cubit.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/states.dart';
import 'package:meal_monkey/shared/components/constants.dart';

import '../../shared/components/components.dart';
import '../menu-Details-Screen/widgets/food_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return BlocConsumer<HomeCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
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
                  child: defaultFormField(
                      radius: 50,
                      prefix: FontAwesomeIcons.magnifyingGlass,
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value) {},
                      label: 'Search Food'),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Popular Items',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 22,
                      ),
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
                      itemCount: HomeCubit.get(context).fav.length),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Recent Items',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 22,
                      ),
                ),
                const SizedBox(height: 20),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => FoodItem(
                          item: HomeCubit.get(context).recentItems.isNotEmpty
                              ? HomeCubit.get(context).recentItems[index]
                              : items[index],
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 15,
                        ),
                    itemCount: HomeCubit.get(context).recentItems.isNotEmpty
                        ? HomeCubit.get(context).recentItems.length < 5
                            ? HomeCubit.get(context).recentItems.length
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
        );
      },
    );
  }
}
