import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/screens/auth_screen.dart';
import 'package:ssn/screens/comments_screen.dart';
import 'package:ssn/screens/home_screen.dart';
import 'package:ssn/screens/post_screen.dart';
import 'package:ssn/screens/profile_screen.dart';
import 'package:ssn/screens/setting_screen.dart';

class App extends StatelessWidget {
  final Store appStore;
  App({this.appStore});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: appStore,
      child: MaterialApp(
        title: "SSN",
        initialRoute: "/",
        routes: {
          "/": (context) => HomeScreen(),
          "/auth": (context) => AuthScreen(),
          "/profile": (context) => ProfileScreen(),
          "/setting": (context) => SettingScreen(),
          "/post": (context) => PostScreen(),
          "/comments": (context) => CommentsScreen(),
        },
      ),
    );
  }
}
