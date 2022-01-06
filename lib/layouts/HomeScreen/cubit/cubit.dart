import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/states.dart';
import 'package:meal_monkey/models/item_data_modell.dart';
import 'package:meal_monkey/models/user_data_model.dart';
import 'package:meal_monkey/modules/HomeScreen/home_screen.dart';
import 'package:meal_monkey/modules/MenuScreen/menu_screen.dart';
import 'package:meal_monkey/modules/MoreScreen/more_screen.dart';
import 'package:meal_monkey/modules/OffersScreen/offers_screen.dart';
import 'package:meal_monkey/modules/ProfileScreen/profile_screen.dart';
import 'package:meal_monkey/shared/Network/local/sharedPreferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:meal_monkey/shared/components/constants.dart';

class HomeCubit extends Cubit<HomeScreenStates> {
  HomeCubit() : super(InitHomeState());
  static HomeCubit get(context) => BlocProvider.of(context);
  late UserModel model;
  late String profileImagePath;

  List<Widget> screens = [
    MenuScreen(),
    OffersScreen(),
    ProfileScreen(),
    MoreScreen(),
    HomeScreen(),
  ];
  int currentIndex = 4;
  List<String> titles = [
    'Menu',
    'Latest Offers',
    'Profile',
    'More',
    'Home',
  ];
  void changeBottomNav(int index, context) {
    currentIndex = index;
    emit(ChangeeNavBottomBarState());
  }

  void getUserData() {
    var uid = CacheHelper.getData(key: 'uId');
    print(uid);
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      print(value.data());
      model = UserModel.fromJson(value.data());
      profileImagePath = model.profileImagepath;
      print(model.email);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;
  void changePasswordVisibilty() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye;
    emit(PasswordIconChange());
  }

  bool isClickable = false;
  void changeIsClickForm() {
    isClickable = !isClickable;
    emit(ChangeIsClickFormFieldState());
  }

  final ImagePicker _picker = ImagePicker();
  File? profileimage;

  Future<void> pickProfilePic() async {
    emit(PickProfileImageLoadingState());
    final pickedimage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      profileimage = File(pickedimage.path);
      emit(PickProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(PickProfileImageErrorState());
    }
  }

  void uploadProfilePic({
    required String name,
    required String phone,
    required String address,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImagePath = value;
        profileimage = null;
        updataData(name: name, phone: phone, address: address);
      }).catchError((error) {});
    }).catchError((error) {});
  }

  Future<void> updateUserData({
    required String name,
    required String phone,
    required String address,
  }) async {
    emit(UpdateUserDataLoadingState());

    if (profileimage != null)
      uploadProfilePic(name: name, phone: phone, address: address);
    else
      updataData(name: name, phone: phone, address: address);
  }

  void updataData({
    required String name,
    required String phone,
    required String address,
  }) {
    emit(UpdateUserDataLoadingState());
    UserModel usermodel = UserModel(
      name: name,
      email: model.email,
      phone: phone,
      uId: model.uId,
      profileImagepath: profileImagePath,
      address: address,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(usermodel.toMap())
        .then((value) {
      getUserData();
      changeIsClickForm();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataErrorState());
    });
  }

  List<ItemModel> food = [];
  List<ItemModel> dessert = [];
  List<ItemModel> berverages = [];
  List<ItemModel> promotions = [];
  List<ItemModel> offers = [];
  void getItems() {
    emit(GetItemsDataLoadingState());
    FirebaseFirestore.instance.collection('items').get().then((value) {
      value.docs.forEach((element) {
        items.add(ItemModel.fromJson(element.data()));
        if (ItemModel.fromJson(element.data()).discount != 0) {
          offers.add(ItemModel.fromJson(element.data()));
        }
        if (ItemModel.fromJson(element.data()).category == 'food') {
          food.add(ItemModel.fromJson(element.data()));
        } else if (ItemModel.fromJson(element.data()).category == 'dessert') {
          dessert.add(ItemModel.fromJson(element.data()));
        } else if (ItemModel.fromJson(element.data()).category == 'beverages') {
          berverages.add(ItemModel.fromJson(element.data()));
        } else {
          promotions.add(ItemModel.fromJson(element.data()));
        }
      });
      emit(GetItemsDataSuccessState());
    }).catchError((error) {
      print('{{{{$error}}}}}');
      emit(GetItemsDataErrorState());
    });
  }
}
