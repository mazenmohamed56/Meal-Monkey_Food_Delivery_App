import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/models/item_data_modell.dart';
import 'package:meal_monkey/modules/CartScreen/cubit/states.dart';
import 'package:meal_monkey/shared/Network/local/databaseHelper.dart';
import 'package:meal_monkey/shared/components/constants.dart';

class CartScreenCubit extends Cubit<CartScreenStates> {
  CartScreenCubit() : super(InitCartState());
  static CartScreenCubit get(context) => BlocProvider.of(context);
  List<Map<String, dynamic>> cart = [];
  List<ItemModel> cartItems = [];
  DatabaseHelper db = DatabaseHelper();
  num cartTotalprice = 0;
  getdata() async {
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
    required int pricePerPortion,
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

  checkOut() {
    db.delete();
    cart = [];
    cartItems = [];
    cartTotalprice = 0;
    emit(GetCartDataLoading());
  }
}
