import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/modules/item%20Details%20Screen/cubit/states.dart';

class ItemDetailsScreenCubit extends Cubit<ItemDetailsScreenStates> {
  ItemDetailsScreenCubit() : super(InitHomeState());
  static ItemDetailsScreenCubit get(context) => BlocProvider.of(context);
  int numberOfPortions = 1;

  late var totalPrice;
  late var itemPrice;

  void setPrices(var itemprice) {
    itemPrice = itemprice;
    totalPrice = itemprice;
  }

  void changeNumberOfPortions(String typeOfChanfe) {
    if (typeOfChanfe == '-') {
      if (numberOfPortions > 1) {
        numberOfPortions--;
      }
    }
    if (typeOfChanfe == '+') {
      numberOfPortions++;
    }
    totalPrice = numberOfPortions * itemPrice;
    emit(ChangeNumberOfPortionsState());
  }
}
