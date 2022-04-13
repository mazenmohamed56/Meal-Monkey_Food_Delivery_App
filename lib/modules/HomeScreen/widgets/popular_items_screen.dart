import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/models/item_data_modell.dart';
import 'package:meal_monkey/modules/menu-Details-Screen/widgets/food_item.dart';
import 'package:meal_monkey/shared/components/constants.dart';

import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class PopularItemsScreen extends StatelessWidget {
  final List<ItemModel> fav;
  PopularItemsScreen({required this.fav});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: AppBar(
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(FontAwesomeIcons.chevronLeft,
                  size: 20, color: placeholder),
            ),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'Popular Items',
              style: Theme.of(context).textTheme.headline3,
            ),
            actions: [
              cartIcon(context: context),
            ],
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView.separated(
              itemBuilder: (context, index) => FoodItem(
                    item: recentItems[index],
                  ),
              separatorBuilder: (context, index) => SizedBox(height: 15),
              itemCount: fav.length)),
    );
  }
}
