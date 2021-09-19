import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/states.dart';
import 'package:meal_monkey/models/user_data_model.dart';
import 'package:meal_monkey/shared/Network/local/sharedPreferences.dart';

class HomeCubit extends Cubit<HomeScreenStates> {
  HomeCubit() : super(InitHomeState());
  static HomeCubit get(context) => BlocProvider.of(context);
  late UserModel model;

  void getUserData() {
    var uid = CacheHelper.getData(key: 'uId');
    print(uid);
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      print(value.data());
      model = UserModel.fromJson(value.data());
      print(model.email);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }
}
