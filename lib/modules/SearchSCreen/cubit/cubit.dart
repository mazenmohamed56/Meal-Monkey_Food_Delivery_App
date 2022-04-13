import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/models/item_data_modell.dart';
import 'package:meal_monkey/modules/SearchSCreen/cubit/states.dart';
import 'package:meal_monkey/shared/components/constants.dart';

class SearchScreenCubit extends Cubit<SearchScreenStates> {
  SearchScreenCubit() : super(InitSearchScreenState());
  static SearchScreenCubit get(context) => BlocProvider.of(context);
  List<ItemModel> searchList = [];
  void initData(s) {
    search(s);
  }

  search(String s) {
    searchList = items.where((element) => element.title.contains(s)).toList();

    emit(SuccessSearchScreenState());
  }
}
