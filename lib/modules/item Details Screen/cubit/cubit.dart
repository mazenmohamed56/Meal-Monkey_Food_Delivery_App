import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_monkey/modules/item%20Details%20Screen/cubit/states.dart';
import 'package:meal_monkey/shared/Network/local/databaseHelper.dart';
import 'package:meal_monkey/shared/components/constants.dart';
import '../../../models/favorite_model.dart';
import '../../../shared/Network/local/sharedPreferences.dart';
import '../../../shared/Network/remote/firebase_helper.dart';

class ItemDetailsScreenCubit extends Cubit<ItemDetailsScreenStates> {
  ItemDetailsScreenCubit() : super(InitHomeState());
  static ItemDetailsScreenCubit get(context) => BlocProvider.of(context);
  int numberOfPortions = 1;
  DatabaseHelper db = DatabaseHelper();
  FirebaseHelper firebaseHelper = FirebaseHelper();
  late bool fav;

  late var totalPrice;
  late var itemPrice;

  void setPrices(var itemprice) {
    itemPrice = itemprice;
    totalPrice = itemprice;
  }

  void setFav(String id) {
    fav = favorites.contains(
        favorites.firstWhere((element) => element.id == id, orElse: () {
      return FavoriteModel(id: '0');
    }));
    print(';;;;;;;;;;;; $fav');
    emit(ChangeFavColorState());
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
    var uid = CacheHelper.getData(key: 'uId');

    emit(AddToCartLoadingState());
    db.insertToDatabase(
        id: id, itemCount: itemCount, totalPrice: totalPrice, uid: uid);
    emit(AddToCartSuccessState());
  }

  Future<void> changeFavoriteColor(String id) async {
    FavoriteModel favoritModel = FavoriteModel(id: id);
    emit(ChangeFavColorState());

    if (fav == false) {
      fav = !fav;
      await firebaseHelper
          .postData(
        col: 'users',
        doc: userModel.uId,
        secCol: 'favorites',
        secdoc: id,
        model: favoritModel,
      )
          .then((value) async {
        await getFavorites();
        emit(AddFavState());
      }).catchError((error) {
        print(error.toString());
      });
    } else {
      fav = !fav;
      await firebaseHelper
          .deletData(
        col: 'users',
        doc: userModel.uId,
        secCol: 'favorites',
        secdoc: id,
        model: favoritModel,
      )
          .then((value) async {
        await getFavorites();
        emit(RemoveFavState());
      }).catchError((error) {
        print(error.toString());
      });
    }
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
      emit(GetFavState());
    }).catchError((error) {});
  }
}
