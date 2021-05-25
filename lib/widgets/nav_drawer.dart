import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssn/actions/user_actions.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/helpers/token_handler.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map<String, dynamic>>(
      converter: (store) => store.state.user,
      builder: (context, user) {
        bool isAuth = user["isAuth"];

        return Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(child: Text('header')),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Posts'),
                onTap: () => Navigator.pushNamed(context, "/"),
              ),
              !isAuth
                  ? ListTile(
                      leading: Icon(FontAwesomeIcons.signInAlt, size: 20),
                      title: Text('Login'),
                      onTap: () => Navigator.pushNamed(context, "/auth"),
                    )
                  : _authRoutes(context),
            ],
          ),
        );
      },
    );
  }

  Widget _authRoutes(context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Profile'),
          onTap: () => Navigator.pushNamed(context, "/profile"),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () => Navigator.pushNamed(context, "/setting"),
        ),
        StoreConnector<AppState, VoidCallback>(
          converter: (store) {
            return () {
              TokenHandler.removeToken();
              store.dispatch(RemoveUserData());
            };
          },
          builder: (context, callback) {
            return ListTile(
              leading: Icon(FontAwesomeIcons.signOutAlt, size: 20),
              title: Text('Logout'),
              onTap: callback,
            );
          },
        )
      ],
    );
  }
}
