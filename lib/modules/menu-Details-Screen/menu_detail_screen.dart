import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/models/item_data_modell.dart';
import 'package:meal_monkey/modules/menu-Details-Screen/widgets/food_item.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

import '../SearchSCreen/widget/searche_field.dart';

// ignore: must_be_immutable
class MenuDetails extends StatelessWidget {
  String appBarTitle;
  List<ItemModel> items;
  MenuDetails(this.appBarTitle, this.items);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                appBarTitle,
                style: Theme.of(context).textTheme.headline3,
              ),
              actions: [
                cartIcon(context: context),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                height: 10,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        FoodItem(item: items[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 15,
                        ),
                    itemCount: items.length),
              ),
              SizedBox(
                height: 45,
              )
            ],
          ),
        ),
      ),
    );
  }
}
