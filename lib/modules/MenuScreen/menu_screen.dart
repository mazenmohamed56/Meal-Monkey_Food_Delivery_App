import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/cubit.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/states.dart';
import 'package:meal_monkey/modules/menu-Details-Screen/menu_detail_screen.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

import '../SearchSCreen/widget/searche_field.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    buildMoreItem(
                        function: () {
                          navigateTo(context,
                              MenuDetails('Food', HomeCubit.get(context).food));
                        },
                        itemCount: HomeCubit.get(context).food.isEmpty
                            ? 0
                            : HomeCubit.get(context).food.length,
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
                        function: () {
                          navigateTo(
                              context,
                              MenuDetails('Beverages',
                                  HomeCubit.get(context).berverages));
                        },
                        itemCount: HomeCubit.get(context).berverages.isEmpty
                            ? 0
                            : HomeCubit.get(context).berverages.length,
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
                        function: () {
                          navigateTo(
                              context,
                              MenuDetails(
                                  'Desserts', HomeCubit.get(context).dessert));
                        },
                        itemCount: HomeCubit.get(context).dessert.isEmpty
                            ? 0
                            : HomeCubit.get(context).dessert.length,
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
                        function: () {
                          navigateTo(
                              context,
                              MenuDetails('Promotions',
                                  HomeCubit.get(context).promotions));
                        },
                        itemCount: HomeCubit.get(context).promotions.isEmpty
                            ? 0
                            : HomeCubit.get(context).promotions.length,
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
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildMoreItem(
      {required BuildContext context,
      required int itemCount,
      required String title,
      required String imagePath,
      required Function function,
      required double a,
      required double b,
      required double c,
      required double d}) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        function();
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
                color: Theme.of(context).scaffoldBackgroundColor,
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
                                  .copyWith(
                                    fontSize: 22,
                                  ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text('$itemCount items',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontSize: 11, color: defaultColor)),
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
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 10,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                width: 33,
                height: 33,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).scaffoldBackgroundColor,
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
