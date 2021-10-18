import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

// ignore: must_be_immutable
class MenuDetails extends StatelessWidget {
  String appBarTitle;
  MenuDetails(this.appBarTitle);
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();

    return Scaffold(
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
      ),
    );
  }

  Widget offerListItem(context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
              image: AssetImage(
                  'assets/images/guy-basabose-FzdEbrA3Qj0-unsplash.jpg'),
              height: 200,
              width: double.infinity,
              fit: BoxFit.fill),
          const SizedBox(height: 10),
          Card(
            margin: EdgeInsets.zero,
            elevation: 20,
            color: Colors.black.withOpacity(0.04),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 21, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Coffe',
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
                      Text('4.9',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: defaultColor)),
                      const SizedBox(width: 5),
                      Text('(120 rating)',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white)),
                      const SizedBox(width: 25),
                      Text('Beverages',
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
        ],
      ),
    );
  }
}
