import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/cubit.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/states.dart';
import 'package:meal_monkey/models/item_data_modell.dart';
import 'package:meal_monkey/modules/item%20Details%20Screen/item_details_sceen.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

// ignore: must_be_immutable
class MenuDetails extends StatelessWidget {
  String appBarTitle;
  List<ItemModel> items;
  MenuDetails(this.appBarTitle, this.items);
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return BlocListener<HomeCubit, HomeScreenStates>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: AppBar(
              leading: Icon(FontAwesomeIcons.chevronLeft,
                  size: 20, color: placeholder),
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Color(0xFFffffff),
              title: Text(
                appBarTitle,
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
                child: defaultFormField(
                    radius: 50,
                    prefix: FontAwesomeIcons.search,
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (value) {},
                    label: 'Search Food'),
              ),
              SizedBox(
                height: 10,
              ),
              const SizedBox(height: 20),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => listItem(context, index),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                  itemCount: items.length),
              SizedBox(
                height: 45,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem(context, int index) {
    return InkWell(
      onTap: () {
        navigateTo(context, ItemDetailsScreen(items[index]));
      },
      child: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image(
                image: NetworkImage('${items[index].imagepath}'),
                height: 200,
                width: double.infinity,
                fit: BoxFit.fill),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 20,
                color: Colors.black.withOpacity(0.04),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 21, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${items[index].title}',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidStar,
                            color: defaultColor,
                            size: 14,
                          ),
                          const SizedBox(width: 5),
                          Text('${items[index].rate}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: defaultColor)),
                          const SizedBox(width: 5),
                          Text('(rating)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white)),
                          const SizedBox(width: 25),
                          Text('${items[index].category}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (items[index].discount != 0)
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  color: defaultColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    'OFFER',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
