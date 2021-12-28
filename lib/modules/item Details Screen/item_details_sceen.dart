import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/models/item_data_modell.dart';
import 'package:meal_monkey/modules/CartScreen/cart_screen.dart';
import 'package:meal_monkey/modules/item%20Details%20Screen/cubit/cubit.dart';
import 'package:meal_monkey/modules/item%20Details%20Screen/cubit/states.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

class ItemDetailsScreen extends StatelessWidget {
  final ItemModel item;
  ItemDetailsScreen(this.item);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ItemDetailsScreenCubit()
        ..setPrices(item.discount != 0 ? item.discount : item.price),
      child: BlocConsumer<ItemDetailsScreenCubit, ItemDetailsScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ItemDetailsScreenCubit.get(context);
          return Scaffold(
            body: Stack(
              children: [
                Image(
                  image: NetworkImage('${item.imagepath}'),
                  width: double.infinity,
                  height: size.height * 0.48,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Material(
                    elevation: 20,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(FontAwesomeIcons.chevronLeft,
                              size: 20, color: Colors.white70),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 20.0),
                              child: Icon(FontAwesomeIcons.shoppingCart,
                                  size: 25, color: Colors.white70),
                            ))
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35)),
                        color: Colors.transparent),
                    height: size.height * 0.6,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(35)),
                            ),
                            height: size.height * 0.6 - 30,
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 45,
                                    ),
                                    Text('${item.title}',
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(fontSize: 22)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RatingBar.builder(
                                              itemSize: 30,
                                              initialRating:
                                                  double.parse(item.rate),
                                              ignoreGestures: true,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding:
                                                  EdgeInsetsDirectional.only(
                                                      end: 1.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: defaultColor,
                                                size: 10,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text('${item.rate} Ratings',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: defaultColor))
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('\$ ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2!
                                                        .copyWith(
                                                            fontSize: 31)),
                                                if (item.discount != 0)
                                                  Text('${item.discount} ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2!
                                                          .copyWith(
                                                              fontSize: 31)),
                                                Text('${item.price}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2!
                                                        .copyWith(
                                                            fontSize:
                                                                item.discount !=
                                                                        0
                                                                    ? 15
                                                                    : 31,
                                                            decoration: item
                                                                        .discount !=
                                                                    0
                                                                ? TextDecoration
                                                                    .lineThrough
                                                                : TextDecoration
                                                                    .none,
                                                            decorationColor:
                                                                defaultColor)),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(start: 25.0),
                                              child: Text('/ per Portion',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text('Description',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('${item.description}',
                                        maxLines: 3,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Number of Portions',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      elevation: 10,
                                                      child: defaultButton(
                                                          function: () {
                                                            cubit
                                                                .changeNumberOfPortions(
                                                                    '-');
                                                          },
                                                          text: '-',
                                                          width: 20,
                                                          radius: 20,
                                                          height: 30),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: defaultButton(
                                                        function: () {},
                                                        text:
                                                            '${cubit.numberOfPortions}',
                                                        width: 20,
                                                        backgroundColor:
                                                            Colors.white,
                                                        fontColor: defaultColor,
                                                        borderWidth: 1,
                                                        radius: 20,
                                                        height: 30),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      elevation: 10,
                                                      child: defaultButton(
                                                          function: () {
                                                            cubit
                                                                .changeNumberOfPortions(
                                                                    '+');
                                                          },
                                                          text: '+',
                                                          radius: 20,
                                                          width: 20,
                                                          height: 30),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ]),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    buildMoreItem(
                                        context: context,
                                        title: 'title',
                                        cubit: cubit),
                                    SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 10),
                          child: Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Material(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadiusDirectional.only(
                                  topStart: Radius.circular(20),
                                  bottomStart: Radius.circular(100),
                                  topEnd: Radius.circular(100),
                                  bottomEnd: Radius.circular(20)),
                              elevation: 20,
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  FontAwesomeIcons.solidHeart,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildMoreItem({
    required BuildContext context,
    required String title,
    required ItemDetailsScreenCubit cubit,
  }) {
    return Container(
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
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Total Price',
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text('\$ ${cubit.totalPrice}',
                          style: Theme.of(context).textTheme.headline1),
                      SizedBox(
                        height: 10,
                      ),
                      defaultButton(
                          function: () {
                            cubit.addToCart(
                                id: item.id,
                                itemCount: cubit.numberOfPortions,
                                totalPrice: cubit.totalPrice);
                            showToast(msg: 'Added Successfully');
                          },
                          isUpperCase: false,
                          prefix: FontAwesomeIcons.cartPlus,
                          text: 'Add to Cart',
                          height: 40,
                          radius: 30)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xFFFFFFFF),
            elevation: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              width: 53,
              height: 53,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0xFFFFFFFF),
              ),
              child: IconButton(
                iconSize: 25,
                icon: Icon(
                  FontAwesomeIcons.shoppingCart,
                  size: 25,
                  color: defaultColor,
                ),
                onPressed: () {
                  navigateTo(context, CartScreen());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
