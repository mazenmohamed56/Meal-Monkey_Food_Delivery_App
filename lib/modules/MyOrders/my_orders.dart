import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_monkey/modules/MyOrders/cubit/cubit.dart';
import 'package:meal_monkey/modules/MyOrders/cubit/states.dart';
import 'package:meal_monkey/modules/MyOrders/widgets/order_list_item.dart';
import 'package:meal_monkey/shared/components/constants.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyOrdersCubit(),
      child: BlocConsumer<MyOrdersCubit, MyOrdersStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                    'My Orders',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  actions: [
                    cartIcon(context: context),
                  ],
                ),
              ),
            ),
            body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: RefreshIndicator(
                  onRefresh: () {
                    return MyOrdersCubit.get(context).getMyOrders();
                  },
                  child: ListView.separated(
                      itemBuilder: (context, index) => OrderListItem(
                            orderModel: myOrders[index],
                          ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 15),
                      itemCount: myOrders.length),
                )),
          );
        },
      ),
    );
  }
}
