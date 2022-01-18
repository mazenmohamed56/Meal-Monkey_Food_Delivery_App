import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/models/item_data_modell.dart';
import 'package:meal_monkey/models/order_data_model.dart';
import 'package:meal_monkey/modules/CartScreen/cubit/states.dart';
import 'package:meal_monkey/modules/MapScreen/map_screen.dart';
import 'package:meal_monkey/shared/Network/local/databaseHelper.dart';
import 'package:meal_monkey/shared/Network/remote/firebase_helper.dart';
import 'package:meal_monkey/shared/components/constants.dart';

class CartScreenCubit extends Cubit<CartScreenStates> {
  CartScreenCubit() : super(InitCartState());
  static CartScreenCubit get(context) => BlocProvider.of(context);
  List<Map<String, dynamic>> cart = [];
  List<ItemModel> cartItems = [];
  DatabaseHelper db = DatabaseHelper();
  num cartTotalprice = 0;
  int paymentMethodRadioSelectedValue = -1;
  var notesController = TextEditingController();
  FirebaseHelper firebaseHelper = FirebaseHelper();

  getdata() async {
    cart = [];
    cartItems = [];
    emit(GetCartDataLoading());
    db.getdata().then((value) {
      value.forEach((e) {
        cart.add(Map<String, dynamic>.from(e));
      });
      calculateTotalPrice();
      print(cartTotalprice);
      getItemsData();
    });
  }

  getItemsData() {
    if (cart.isNotEmpty) {
      cart.forEach((cartElement) {
        cartItems.add(items
            .firstWhere((itemElement) => itemElement.id == cartElement['id']));
      });
    }
    emit(GetCartDataSuccess());
  }

  updateCartItem({
    required String typeOfChange,
    required int index,
    required num pricePerPortion,
  }) {
    int itemcount = cart[index]['itemCount'];
    if (typeOfChange == '-') {
      if (cart[index]['itemCount'] > 1) {
        itemcount--;
        cart[index].update('itemCount', (value) => itemcount);
        cart[index]['totalPrice'] = pricePerPortion * cart[index]['itemCount'];
        calculateTotalPrice();
        emit(UpdateCartSuccessState());

        db.updateDate(
            itemCount: cart[index]['itemCount'],
            id: cart[index]['id'],
            totalPrice: cart[index]['totalPrice']);
      }
    } else {
      itemcount++;
      cart[index].update('itemCount', (value) => itemcount);
      cart[index]['totalPrice'] = pricePerPortion * cart[index]['itemCount'];
      calculateTotalPrice();
      print(cartTotalprice);
      emit(UpdateCartSuccessState());

      db.updateDate(
          itemCount: cart[index]['itemCount'],
          id: cart[index]['id'],
          totalPrice: cart[index]['totalPrice']);
    }
  }

  calculateTotalPrice() {
    cartTotalprice = 0;
    cart.forEach((element) {
      cartTotalprice = cartTotalprice + element['totalPrice'];
    });
  }

  deletItem({required int index, required String id}) {
    cart.removeAt(index);
    cartItems.removeAt(index);
    calculateTotalPrice();
    emit(DeletItemSuccessState());
    db.delteData(id: id);
  }

  Future<void> sendOrder() async {
    emit(SendOrderLoadingState());
    await Future.delayed(Duration(seconds: 2));
    var randomId = FirebaseFirestore.instance.collection('orders').doc().id;
    List<Item> data = [];

    for (int index = 0; index < cartItems.length; index++) {
      Item e = new Item(
          id: cartItems[index].id,
          title: cartItems[index].title,
          itemCount: cart[index]['itemCount'],
          totalPrice: cart[index]['totalPrice']);
      data.add(e);
    }
    OrderModel model = OrderModel(
        orderId: randomId,
        userId: userModel.uId,
        status: 'Being processed',
        paymentMethod: 'Cash on delivery',
        address: selectedAddress['address'] == ''
            ? userModel.address
            : selectedAddress['address'],
        geoAddress: selectedAddress['geoPoint'] != GeoPoint(0, 0)
            ? selectedAddress['geoPoint']
            : userModel.geoAddress,
        note: notesController.text,
        data: data,
        delevryPrice: 2,
        subPrice: cartTotalprice,
        totalPrice: cartTotalprice + 2,
        discount: 0,
        dateTime: DateTime.now().toString());
    firebaseHelper.postData('orders', randomId, model).then((value) {
      db.delete();
      cart = [];
      cartItems = [];
      cartTotalprice = 0;
      notesController.text = '';
      emit(SendOrderSuccessState());
    }).catchError((error) {
      emit(SendOrderErrorState());
    });
  }

  changeRadioValue(value) {
    paymentMethodRadioSelectedValue = value;
    emit(ChangeRadioValueState());
  }

  Map selectedAddress = {'address': '', 'geoPoint': GeoPoint(0, 0)};

  changeAddress(context) async {
    selectedAddress = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapScreen()));
    print('------------$selectedAddress');
    emit(SetSelectedAddressSuccessState());
  }
}
