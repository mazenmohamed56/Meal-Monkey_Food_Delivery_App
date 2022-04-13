import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/modules/MyOrders/cubit/states.dart';
import 'package:meal_monkey/shared/Network/remote/firebase_helper.dart';

import '../../../models/order_data_model.dart';
import '../../../shared/components/constants.dart';

class MyOrdersCubit extends Cubit<MyOrdersStates> {
  MyOrdersCubit() : super(InitAppState());
  static MyOrdersCubit get(context) => BlocProvider.of(context);
  FirebaseHelper firebaseHelper = new FirebaseHelper();

  Future<void> getMyOrders() async {
    myOrders = [];
    recentItems = [];
    emit(GetOrdersDataLoadingState());
    await firebaseHelper
        .getCollectionData(
            coll: 'users',
            doc: userModel.uId,
            secCol: 'Orders',
            orderdby: 'dateTime')
        .then((value) {
      value.docs.forEach((element) {
        myOrders.add(OrderModel.fromJson(element.data()));
      });
      emit(GetOrdersDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetOrdersDataErrorState());
    });
    myOrders.forEach((element) {
      element.data.forEach((element) {
        if (recentItems.contains(items.firstWhere(
                (itemElement) => itemElement.id == element['id'])) ==
            false)
          recentItems.add(items
              .firstWhere((itemElement) => itemElement.id == element['id']));
      });
    });
  }
}
