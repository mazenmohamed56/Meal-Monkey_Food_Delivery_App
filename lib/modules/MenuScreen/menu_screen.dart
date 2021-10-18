import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/modules/menu-Details-Screen/menu_detail_screen.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return Column(
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
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    buildMoreItem(
                        context: context,
                        title: 'Food',
                        imagePath:
                            'assets/images/davide-cantelli-jpkfc5_d-DI-unsplash.jpg',
                        a: 50,
                        b: 50,
                        c: 50,
                        d: 50),
                    const SizedBox(
                      height: 20,
                    ),
                    buildMoreItem(
                        context: context,
                        title: 'Beverages',
                        imagePath:
                            'assets/images/guy-basabose-FzdEbrA3Qj0-unsplash.jpg',
                        a: 20,
                        b: 20,
                        c: 20,
                        d: 20),
                    const SizedBox(
                      height: 20,
                    ),
                    buildMoreItem(
                        context: context,
                        title: 'Desserts',
                        imagePath:
                            'assets/images/kobby-mendez-idTwDKt2j2o-unsplash.jpg',
                        a: 30,
                        b: 20,
                        c: 100,
                        d: 30),
                    const SizedBox(
                      height: 20,
                    ),
                    buildMoreItem(
                        context: context,
                        title: 'Promotions',
                        imagePath:
                            'assets/images/ilya-mashkov-_qxbJUr9RqI-unsplash.jpg',
                        a: 20,
                        b: 100,
                        c: 100,
                        d: 20),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget buildMoreItem(
      {required BuildContext context,
      required String title,
      required String imagePath,
      required double a,
      required double b,
      required double c,
      required double d}) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        navigateTo(context, MenuDetails(title));
      },
      child: Container(
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 15, start: 35),
              child: Material(
                elevation: 20,
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(30),
                    bottomStart: Radius.circular(30),
                    topEnd: Radius.circular(15),
                    bottomEnd: Radius.circular(15)),
                color: Color(0xFFFFFFFF),
                child: Container(
                  height: 87,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$title',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 22),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text('112 items',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 11,
                                      color: placeholder,
                                    )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                clipBehavior: Clip.antiAlias,
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(a),
                      bottomStart: Radius.circular(b),
                      topEnd: Radius.circular(c),
                      bottomEnd: Radius.circular(d)),
                ),
                child:
                    Image(fit: BoxFit.cover, image: AssetImage('$imagePath')),
              ),
            ),
            Material(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xFFFFFFFF),
              elevation: 10,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                width: 33,
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFFFFFFFF),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Icon(
                      FontAwesomeIcons.chevronRight,
                      size: 20,
                      color: defaultColor,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
