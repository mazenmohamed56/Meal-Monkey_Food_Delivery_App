import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/models/user_data_model.dart';
import 'package:meal_monkey/modules/SignUpScreen/cubit/states.dart';
import 'package:meal_monkey/shared/Network/remote/firebase_helper.dart';

class RegisterCubit extends Cubit<RegisterScreenStates> {
  RegisterCubit() : super(InitRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  FirebaseHelper firebaseHelper = new FirebaseHelper();

  void postRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String address,
    required GeoPoint geoAddress,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
          geoAddress: GeoPoint(0, 0),
          address: address);
      print(value.user!.email);
      emit(RegisterSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String address,
    required GeoPoint geoAddress,
  }) {
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        address: address,
        geoAddress: geoAddress,
        profileImagepath:
            'https://icon-library.com/images/anonymous-person-icon/anonymous-person-icon-18.jpg');

    firebaseHelper.postData(col: 'users', doc: uId, model: model).then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;
  void changePasswordVisibilty() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye;
    emit(RegisterPasswordIconChange());
  }
}
