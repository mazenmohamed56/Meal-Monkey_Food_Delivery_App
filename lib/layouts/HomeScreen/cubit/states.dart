import 'package:flutter/material.dart';

abstract class HomeScreenStates {}

class InitHomeState extends HomeScreenStates {}

class ChangeeNavBottomBarState extends HomeScreenStates {}

class PasswordIconChange extends HomeScreenStates {}

class GetUserDataLoadingState extends HomeScreenStates {}

class GetUserDataSuccessState extends HomeScreenStates {}

class GetUserDataErrorState extends HomeScreenStates {
  @required
  String error;
  GetUserDataErrorState(this.error);
}

class ChangeIsClickFormFieldState extends HomeScreenStates {}

class PickProfileImageLoadingState extends HomeScreenStates {}

class PickProfileImageSuccessState extends HomeScreenStates {}

class PickProfileImageErrorState extends HomeScreenStates {}

class GetItemsDataLoadingState extends HomeScreenStates {}

class GetItemsDataSuccessState extends HomeScreenStates {}

class GetItemsDataErrorState extends HomeScreenStates {}

class UpdateUserDataLoadingState extends HomeScreenStates {}

class UpdateUserDataSuccessState extends HomeScreenStates {}

class UpdateUserDataErrorState extends HomeScreenStates {}
