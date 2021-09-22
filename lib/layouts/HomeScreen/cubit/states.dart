import 'package:flutter/material.dart';

abstract class HomeScreenStates {}

class InitHomeState extends HomeScreenStates {}

class ChangeeNavBottomBarState extends HomeScreenStates {}

class GetUserDataLoadingState extends HomeScreenStates {}

class GetUserDataSuccessState extends HomeScreenStates {}

class GetUserDataErrorState extends HomeScreenStates {
  @required
  String error;
  GetUserDataErrorState(this.error);
}
