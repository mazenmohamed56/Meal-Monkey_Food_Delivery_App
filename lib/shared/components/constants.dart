import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_monkey/models/item_data_modell.dart';
import 'package:meal_monkey/modules/LoginScreen/login_sreen.dart';
import 'package:meal_monkey/shared/Network/local/sharedPreferences.dart';

import 'components.dart';

List<ItemModel> items = [];

void signOut(context) {
  CacheHelper.removeData(
    key: 'uId',
  ).then((value) async {
    if (value) {
      if (await GoogleSignIn().isSignedIn()) {
        await GoogleSignIn().signOut();
        navigateAndFinsh(
          context,
          LoginScreen(),
        );
      } else if (await FacebookLogin().isLoggedIn) {
        await FacebookLogin().logOut();

        navigateAndFinsh(
          context,
          LoginScreen(),
        );
      } else
        await FirebaseAuth.instance.signOut().then((value) {
          navigateAndFinsh(
            context,
            LoginScreen(),
          );
        });
    }
  });
}
