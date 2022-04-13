import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_monkey/models/user_data_model.dart';
import 'package:meal_monkey/modules/LoginScreen/cubit/states.dart';

class LoginCubit extends Cubit<LoginScreenStates> {
  late UserModel loginmodel;
  LoginCubit() : super(InitLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);
  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid.toString());
      emit(LoginSuccessState(value.user!.uid.toString()));
    }).catchError((error) {
      emit(LoginErrorState(error));
    });
  }

  IconData suffix = Icons.remove_red_eye_outlined;
  bool isPassword = true;
  void changePasswordVisibilty() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye;
    emit(LoginPasswordIconChange());
  }

  fbSignIn() async {
    final fb = FacebookLogin();

// Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        final AuthCredential authCredential =
            FacebookAuthProvider.credential(accessToken!.token);
        await FirebaseAuth.instance
            .signInWithCredential(authCredential)
            .then((user) {
          //Create Doc to save user Data

          createDoc(user);
        });

        // Get profile data

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }

  void googleSignIn() {
    signInWithGoogle();
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
        //Create Doc to save user Data
        createDoc(user);
      });
    } catch (e) {
      print(e);
    }
  }
  //Create Doc to save user Data

  void createDoc(var user) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.user!.uid)
        .get()
        .then((value) async {
      print(';;;;;;  ${value.exists}');
      print(';;;;;;  ${user.user!.uid}');
      if (value.exists == false) {
        UserModel model = UserModel(
            name: user.user!.displayName.toString(),
            email: user.user!.email.toString(),
            uId: user.user!.uid,
            profileImagepath: user.user!.photoURL.toString(),
            address: ('Please add your address'),
            geoAddress: GeoPoint(0, 0),
            phone: 'Please add your phone number');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.user!.uid)
            .set(model.toMap())
            .then((value) {})
            .catchError((error) {
          print(error.toString());
        });
      }
      emit(LoginSuccessState(
        user.user!.uid,
      ));
    });
  }
}
