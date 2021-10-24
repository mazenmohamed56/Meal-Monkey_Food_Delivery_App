import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/modules/item%20Details%20Screen/cubit/states.dart';

class ItemDetailsScreenCubit extends Cubit<ItemDetailsScreenStates> {
  ItemDetailsScreenCubit() : super(InitHomeState());
  static ItemDetailsScreenCubit get(context) => BlocProvider.of(context);
  int numberOfPortions = 1;
  int item = 750;
  var totalPrice = 750;

  void changeNumberOfPortions(String typeOfChanfe) {
    if (typeOfChanfe == '-') {
      if (numberOfPortions > 1) {
        numberOfPortions--;
      }
    }
    if (typeOfChanfe == '+') {
      numberOfPortions++;
    }
    totalPrice = numberOfPortions * item;
    emit(ChangeNumberOfPortionsState());
  }
}
