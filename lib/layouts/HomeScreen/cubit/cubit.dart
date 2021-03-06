import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_monkey/layouts/HomeScreen/cubit/states.dart';
import 'package:meal_monkey/models/favorite_model.dart';
import 'package:meal_monkey/models/item_data_modell.dart';
import 'package:meal_monkey/models/order_data_model.dart';
import 'package:meal_monkey/models/user_data_model.dart';
import 'package:meal_monkey/modules/HomeScreen/home_screen.dart';
import 'package:meal_monkey/modules/MapScreen/map_screen.dart';
import 'package:meal_monkey/modules/MenuScreen/menu_screen.dart';
import 'package:meal_monkey/modules/MoreScreen/more_screen.dart';
import 'package:meal_monkey/modules/OffersScreen/offers_screen.dart';
import 'package:meal_monkey/modules/ProfileScreen/profile_screen.dart';
import 'package:meal_monkey/shared/Network/local/sharedPreferences.dart';
import 'package:meal_monkey/shared/Network/remote/firebase_helper.dart';
import 'package:meal_monkey/shared/components/constants.dart';

import '../../../shared/Network/local/databaseHelper.dart';

class HomeCubit extends Cubit<HomeScreenStates> {
  HomeCubit() : super(InitHomeState());
  static HomeCubit get(context) => BlocProvider.of(context);
  late String profileImagePath;
  FirebaseHelper firebaseHelper = new FirebaseHelper();

  DatabaseHelper db = DatabaseHelper();

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

  Future<void> getUserData() async {
    var uid = CacheHelper.getData(key: 'uId');
    print('<<<<<<<<<<<<  $uid');
    emit(GetUserDataLoadingState());
    await firebaseHelper.getDocData('users', uid).then((value) async {
      print(value.data());
      userModel = UserModel.fromJson(value.data());
      profileImagePath = userModel.profileImagepath;
      print(userModel.email);
      await getMyOrders();
      await getFavorites();
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

  Future<void> updateUserData({
    required String name,
    required String phone,
    required String address,
    required GeoPoint geoAddress,
  }) async {
    emit(UpdateUserDataLoadingState());

    if (profileimage != null) {
      profileImagePath = await firebaseHelper.uploadFile('users',
          Uri.file(profileimage!.path).pathSegments.last, profileimage);
      profileimage = null;
      updataData(
          name: name, phone: phone, address: address, geoAddress: geoAddress);
    } else
      updataData(
          name: name, phone: phone, address: address, geoAddress: geoAddress);
  }

  Future<void> updataData({
    required String name,
    required String phone,
    required String address,
    required GeoPoint geoAddress,
  }) async {
    emit(UpdateUserDataLoadingState());
    UserModel usermodel = UserModel(
      name: name,
      email: userModel.email,
      phone: phone,
      uId: userModel.uId,
      geoAddress: geoAddress,
      profileImagepath: profileImagePath,
      address: address,
    );
    await firebaseHelper
        .updateDocData('users', userModel.uId, usermodel)
        .then((value) {
      getUserData();
      changeIsClickForm();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataErrorState());
    });
  }

  List<ItemModel> food = [];
  List<ItemModel> fav = [];
  List<ItemModel> dessert = [];
  List<ItemModel> berverages = [];
  List<ItemModel> promotions = [];
  List<ItemModel> offers = [];
  Future<void> getItems() async {
    items = [];
    food = [];
    fav = [];
    dessert = [];
    berverages = [];
    promotions = [];
    offers = [];
    emit(GetItemsDataLoadingState());
    var value;
    await firebaseHelper.getCollectionData(coll: 'items').then((val) {
      value = val;
    }).catchError((error) {
      emit(GetItemsDataErrorState());
    });

    value.docs.forEach((element) {
      items.add(ItemModel.fromJson(element.data()));
      if (ItemModel.fromJson(element.data()).discount != 0) {
        offers.add(ItemModel.fromJson(element.data()));
      }
      if (double.parse(ItemModel.fromJson(element.data()).rate) >= 4.5) {
        fav.add(ItemModel.fromJson(element.data()));
      }
      switch (ItemModel.fromJson(element.data()).category) {
        case 'food':
          food.add(ItemModel.fromJson(element.data()));
          break;
        case 'dessert':
          dessert.add(ItemModel.fromJson(element.data()));
          break;
        case 'beverages':
          berverages.add(ItemModel.fromJson(element.data()));
          break;

        default:
          promotions.add(ItemModel.fromJson(element.data()));
      }
    });

    print(items.length);
    emit(GetItemsDataSuccessState());
  }

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

  Map selectedAddress = {'address': '', 'geoPoint': GeoPoint(0, 0)};
  changeAddress(context) async {
    selectedAddress = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapScreen()));
    print('------------$selectedAddress');
    emit(SetSelectedAddressSuccessState());
  }

  Future<void> getFavorites() async {
    favorites = [];
    await firebaseHelper
        .getCollectionData(
            coll: 'users', doc: userModel.uId, secCol: 'favorites')
        .then((value) {
      value.docs.forEach((element) {
        favorites.add(FavoriteModel.fromJson(element.data()));
      });
    }).catchError((error) {});
  }
}
