import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_monkey/shared/cubit/cubit.dart';
import 'package:meal_monkey/shared/styles/colors.dart';

import '../../../models/order_data_model.dart';
import '../../../shared/components/components.dart';
import '../../CartScreen/check_out_dialog.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({
    Key? key,
    required this.orderModel,
  }) : super(key: key);
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return InkWell(
      onTap: () => showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          builder: (BuildContext context) => Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppCubit.get(context).isDark
                      ? Color.fromARGB(255, 25, 27, 40)
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Details :',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Order Id : ${orderModel.orderId}',
                            style: Theme.of(context).textTheme.headline4),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 5),
                          child: Container(
                            color: AppCubit.get(context).isDark
                                ? Color.fromARGB(255, 55, 47, 47)
                                : Colors.grey[200],
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Container(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${orderModel.data[index]['title']} X ${orderModel.data[index]['itemCount']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            Text(
                                              '\$ ${orderModel.data[index]['totalPrice']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    mySeparator(),
                                itemCount: orderModel.data.length),
                          ),
                        ),
                        detailsRow(context, 'Delivery Cost',
                            orderModel.delevryPrice.toString(), 16.0),
                        detailsRow(context, 'Sub Total',
                            orderModel.subPrice.toString(), 16.0),
                        detailsRow(context, 'Discount',
                            '- ${orderModel.discount} ', 18.0),
                        detailsRow(
                            context,
                            'Total Price',
                            (orderModel.subPrice + orderModel.delevryPrice)
                                .toString(),
                            20.0),
                        Text('Delivery Address :',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20)),
                        detailsRowWithTextButton(
                            context: context,
                            title: '${orderModel.address}',
                            fontSize: 15,
                            color: defaultColor,
                            function: () {}),
                      ],
                    ),
                  ),
                ),
              )),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppCubit.get(context).isDark
              ? Color.fromARGB(255, 25, 27, 40)
              : Colors.grey[200],
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(36, 48, 78, 0.80),
              offset: Offset(0.4, 0.5),
              blurRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${orderModel.orderId}'),
                  Text('\$${orderModel.totalPrice}'),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              mySeparator(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${orderModel.data.length} Product(s)'),
                  Text('${orderModel.status}'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${orderModel.paymentMethod}'),
                  Text('${formatter.format(orderModel.dateTime.toDate())}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
