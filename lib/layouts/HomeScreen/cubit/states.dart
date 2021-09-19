import 'package:flutter/material.dart';

abstract class HomeScreenStates {}

class InitHomeState extends HomeScreenStates {}

class LogOutLodingState extends HomeScreenStates {}

class LogOutSuccessState extends HomeScreenStates {}

class LogOutErrorState extends HomeScreenStates {}

class GetUserDataLoadingState extends HomeScreenStates {}

class GetUserDataSuccessState extends HomeScreenStates {}

class GetUserDataErrorState extends HomeScreenStates {
  @required
  String error;
  GetUserDataErrorState(this.error);
}
