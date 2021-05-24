import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:ssn/api/user_api.dart';
import 'package:ssn/app_state.dart';

class SetUserData {
  Map data;
  SetUserData({this.data});
}

class RemoveUserData {
  RemoveUserData();
}

ThunkAction<AppState> userLogin(email, password, context) {
  return (Store<AppState> store) async {
    final response = await UserApi.login(email, password);
    store.dispatch(
        SetUserData(data: {"user": response['user'], "isAuth": true}));
    Navigator.pushNamed(context, "/");
  };
}
