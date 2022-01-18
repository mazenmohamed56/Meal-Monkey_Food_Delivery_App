import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/cubit.dart';
import 'package:meal_monkey/modules/CartScreen/cubit/cubit.dart';
import 'package:meal_monkey/modules/CartScreen/cubit/states.dart';
import 'package:meal_monkey/modules/MapScreen/cubit/cubit.dart';
import 'package:meal_monkey/modules/MapScreen/map_screen.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

Future<dynamic> checkOutDialog(BuildContext context) {
  return showDialog(
      context: context, builder: (context) => new MydialogContent());
}

class MydialogContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartScreenCubit, CartScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CartScreenCubit.get(context);
        var notesController;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: Colors.white,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            FontAwesomeIcons.chevronLeft,
                            size: 20,
                          ),
                        ),
                        Text('Check Out',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 18))
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${cubit.cartItems[index].title} X ${cubit.cart[index]['itemCount']}',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Text(
                                      '\$ ${cubit.cart[index]['totalPrice']}',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => mySeparator(),
                        itemCount: cubit.cartItems.length),
                  ),
                  detailsRow(context, 'Delivery Cost', '2', 16.0),
                  detailsRow(context, 'Sub Total',
                      cubit.cartTotalprice.toString(), 16.0),
                  detailsRow(context, 'Discount', '- 0', 18.0),
                  detailsRow(context, 'Total Price',
                      (cubit.cartTotalprice + 2).toString(), 20.0),
                  detailsRowWithTextButton(
                      context: context,
                      title: 'Instrusctions',
                      subTitle: 'Add Notes',
                      icon: Icons.add,
                      function: () {
                        showDialog(
                            context: context,
                            builder: (context) => Container(
                                  child: Material(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.chevronLeft,
                                                  size: 20,
                                                ),
                                              ),
                                              Text('Add Notes',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(fontSize: 18))
                                            ],
                                          ),
                                          TextFormField(
                                            controller: notesController,
                                            minLines: 1,
                                            maxLines: 8,
                                            decoration: InputDecoration(
                                              hintText:
                                                  'What\'s  on your mind ?',
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      }),
                  detailsRowWithTextButton(
                      context: context,
                      title: 'Payment Method',
                      subTitle: 'Add Card',
                      icon: Icons.add,
                      function: () {}),
                  Material(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        RadioListTile(
                            value: 0,
                            title: Text('Cash on delivery',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 16)),
                            groupValue: cubit.paymentMethodRadioSelectedValue,
                            onChanged: (value) => cubit.changeRadioValue(value))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Delivery Address',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 20)),
                  detailsRowWithTextButton(
                      context: context,
                      title:
                          '${MapScreenCubit.get(context).selectedAddress['address'] == '' ? HomeCubit.get(context).model.address : MapScreenCubit.get(context).selectedAddress['address']}',
                      subTitle: 'Change',
                      fontSize: 15,
                      icon: Icons.change_circle,
                      function: () {
                        cubit.changeAddress(context);
                      }),
                  Expanded(
                      child: Container(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: defaultButton(
                                  radius: 30,
                                  isUpperCase: false,
                                  function: () {
                                    cubit.sendOrder();
                                    Navigator.pop(context);
                                  },
                                  text: "Send Order")))),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget detailsRowWithTextButton(
    {required BuildContext context,
    required String title,
    required String subTitle,
    TextEditingController? notesController,
    double fontSize = 20,
    IconData? icon,
    required Function function}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          '$title',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: fontSize),
        ),
      ),
      TextButton(
        onPressed: () {
          function();
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: defaultColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text('$subTitle',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 16, color: defaultColor)),
          ],
        ),
      )
    ],
  );
}

Widget detailsRow(
    BuildContext context, String title, String data, double fontSize) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        '$title',
        style:
            Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: fontSize),
      ),
      Text(
        '\$ $data',
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: fontSize, color: defaultColor),
      ),
    ]),
  );
}
