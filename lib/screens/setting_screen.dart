import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/user.dart';
import 'package:ssn/widgets/nav_drawer.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SSN"),
      ),
      drawer: NavDrawer(),
      body: StoreConnector<AppState, User>(
        converter: (store) => store.state.user['data'],
        builder: (context, user) {
          return ListView(
            children: [
              Container(
                child: Column(
                  children: [Text('ss')],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
