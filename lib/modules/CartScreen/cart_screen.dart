import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/modules/CartScreen/cubit/cubit.dart';
import 'package:meal_monkey/modules/CartScreen/cubit/states.dart';
import 'package:meal_monkey/shared/components/components.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

import '../../shared/cubit/cubit.dart';
import 'check_out_dialog.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartScreenCubit.get(context).getdata();
    return BlocConsumer<CartScreenCubit, CartScreenStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          var cubit = CartScreenCubit.get(context);

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
                  backgroundColor: AppCubit.get(context).isDark
                      ? Color(0xFF2B2D42)
                      : Color(0xFFffffff),
                  title: Text(
                    'Cart',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25),
                    Expanded(
                      child: Conditional.single(
                        context: context,
                        widgetBuilder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) =>
                              buildCartItem(cubit, index, context),
                          itemCount: cubit.cart.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            height: 5,
                          ),
                        ),
                        conditionBuilder: (BuildContext context) =>
                            cubit.cart.length > 0,
                        fallbackBuilder: (BuildContext context) => Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.no_food_outlined,
                                size: 50,
                              ),
                              Text(
                                'No items in Cart',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Please add some items',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text('\$ ${cubit.cartTotalprice}',
                              style: Theme.of(context).textTheme.headline1),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                      function: () {
                        if (cubit.cart.length > 0)
                          checkOutDialog(context);
                        else
                          showToast(msg: 'Please add some items');
                      },
                      text: 'Check Out',
                      radius: 30,
                      isUpperCase: false,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildCartItem(CartScreenCubit cubit, int index, BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
            color: Colors.deepOrange[300],
            borderRadius: BorderRadius.circular(15)),
        width: 100,
        child: Center(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 180),
            child: Icon(Icons.delete),
          ),
        ),
      ),
      confirmDismiss: (direction) => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: Text('Please Confirm'),
                  content: Text('Are you sure you want to delete?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text('Cancel')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text('Confirm')),
                  ])),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart)
          cubit.deletItem(index: index, id: cubit.cartItems[index].id);
      },
      key: Key(cubit.cartItems[index].id),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Card(
          elevation: 20,
          margin: EdgeInsets.zero,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                  image: NetworkImage('${cubit.cartItems[index].imagepath}'),
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.fill),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Card(
                    elevation: 20,
                    color: Colors.black.withOpacity(0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${cubit.cartItems[index].title}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  'Price per portion : ${cubit.cartItems[index].discount != 0 ? cubit.cartItems[index].discount : cubit.cartItems[index].price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: Colors.white, fontSize: 16)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  'Total Price : ${cubit.cart[index]['totalPrice']}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: Colors.white, fontSize: 16)),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  elevation: 10,
                                  child: defaultButton(
                                      function: () {
                                        cubit.updateCartItem(
                                            typeOfChange: '-',
                                            index: index,
                                            pricePerPortion: cubit
                                                        .cartItems[index]
                                                        .discount !=
                                                    0
                                                ? cubit
                                                    .cartItems[index].discount
                                                : cubit.cartItems[index].price);
                                      },
                                      text: '-',
                                      width: 10,
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
                                    text: '${cubit.cart[index]['itemCount']}',
                                    backgroundColor: Colors.white,
                                    fontColor: defaultColor,
                                    borderWidth: 1,
                                    fontSize: 13,
                                    radius: 20,
                                    height: 30),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  elevation: 10,
                                  child: defaultButton(
                                      function: () {
                                        cubit.updateCartItem(
                                            typeOfChange: '+',
                                            index: index,
                                            pricePerPortion: cubit
                                                        .cartItems[index]
                                                        .discount !=
                                                    0
                                                ? cubit
                                                    .cartItems[index].discount
                                                : cubit.cartItems[index].price);
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
