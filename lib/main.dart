import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:ssn/App.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/reducers/app_reducer.dart';

void main() {
  final store = Store(
    appReducer,
    initialState: AppState(
      posts: [],
      user: {'isAuth': false, "data": {}},
    ),
    middleware: [thunkMiddleware],
  );

  runApp(App(appStore: store));
}
