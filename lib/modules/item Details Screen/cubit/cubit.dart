import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/modules/item%20Details%20Screen/cubit/states.dart';
import 'package:meal_monkey/shared/Network/local/databaseHelper.dart';

class ItemDetailsScreenCubit extends Cubit<ItemDetailsScreenStates> {
  ItemDetailsScreenCubit() : super(InitHomeState());
  static ItemDetailsScreenCubit get(context) => BlocProvider.of(context);
  int numberOfPortions = 1;
  DatabaseHelper db = DatabaseHelper();

  late var totalPrice;
  late var itemPrice;

  void setPrices(var itemprice) {
    itemPrice = itemprice;
    totalPrice = itemprice;
  }

  void changeNumberOfPortions(String typeOfChange) {
    if (typeOfChange == '-') {
      if (numberOfPortions > 1) {
        numberOfPortions--;
      }
    }
    if (typeOfChange == '+') {
      numberOfPortions++;
    }
    totalPrice = numberOfPortions * itemPrice;
    emit(ChangeNumberOfPortionsState());
  }

  void addToCart({
    required String id,
    required int itemCount,
    required int totalPrice,
  }) {
    emit(AddToCartLoadingState());
    db.insertToDatabase(id: id, itemCount: itemCount, totalPrice: totalPrice);
    emit(AddToCartSuccessState());
  }
}
