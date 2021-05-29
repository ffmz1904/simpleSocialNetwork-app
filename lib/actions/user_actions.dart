import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:ssn/actions/error_action.dart';
import 'package:ssn/api/user_api.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/helpers/token_handler.dart';
import 'package:ssn/models/user.dart';

class SetUserData {
  Map data;
  SetUserData({this.data});
}

class RemoveUserData {
  RemoveUserData();
}

class UpdateUserFriends {
  User user;
  User friend;
  UpdateUserFriends({this.user, this.friend});
}

class UpdateUserProfile {
  User user;
  UpdateUserProfile({this.user});
}

ThunkAction<AppState> userRegisterAction(name, email, password, cb) {
  return (Store<AppState> store) async {
    final response = await UserApi.registration(name, email, password);

    if (response['success'] == null) {
      return store.dispatch(SetError(message: response['message']));
    }

    cb();
  };
}

ThunkAction<AppState> userLogin(email, password, context) {
  return (Store<AppState> store) async {
    final response = await UserApi.login(email, password);
    if (response['success'] == null) {
      return store.dispatch(SetError(message: response['message']));
    }

    TokenHandler.setToken(response['token']);
    store.dispatch(SetUserData(
        data: {"user": User.fromMap(response['user']), "isAuth": true}));
    Navigator.pushNamed(context, "/");
  };
}

ThunkAction<AppState> userLogOut() {
  return (Store<AppState> store) async {
    TokenHandler.removeToken();
    store.dispatch(RemoveUserData());
  };
}

ThunkAction<AppState> checkAuthAction() {
  return (Store<AppState> store) async {
    final response = await UserApi.checkAuth();

    if (response['success']) {
      TokenHandler.setToken(response['token']);
      return store.dispatch(SetUserData(
          data: {"user": User.fromMap(response['user']), "isAuth": true}));
    }

    return store.dispatch(RemoveUserData);
  };
}

ThunkAction<AppState> subscribeAction(subscribeToId) {
  return (Store<AppState> store) async {
    final response = await UserApi.subscribe(subscribeToId);

    if (response['success'] == null) {
      return store.dispatch(SetError(message: response['message']));
    }

    store.dispatch(UpdateUserFriends(
        user: User.fromMap(response['user']),
        friend: User.fromMap(response['userSubscribingTo'])));
  };
}

ThunkAction<AppState> unsubscribeAction(unsubscribeId) {
  return (Store<AppState> store) async {
    final response = await UserApi.unsubscribe(unsubscribeId);

    if (response['success'] == null) {
      return store.dispatch(SetError(message: response['message']));
    }

    store.dispatch(UpdateUserFriends(
        user: User.fromMap(response['user']),
        friend: User.fromMap(response['unsubscribedUser'])));
  };
}

ThunkAction<AppState> updateProfileAction(updateData) {
  return (Store<AppState> store) async {
    final response = await UserApi.updateUserProfile(updateData);

    if (response['success'] == null) {
      return store.dispatch(SetError(message: response['message']));
    }

    store.dispatch(UpdateUserProfile(user: User.fromMap(response['user'])));
  };
}
