import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ssn/actions/friends_actions.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/user.dart';
import 'package:ssn/widgets/error_window.dart';
import 'package:ssn/widgets/friends_list_card.dart';
import 'package:ssn/widgets/nav_drawer.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  bool loading = true;
  void setLoading() => setState(() => loading = !loading);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as FriendsScreenArgs;

    if (loading) {
      Store<AppState> store = StoreProvider.of(context);
      Function loadFriendsData =
          getUserFriendsAction(args.userId, args.type, setLoading);
      store.dispatch(loadFriendsData(store));
    }

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("SSN"),
      ),
      body: StoreConnector<AppState, List<User>>(
        converter: (store) => store.state.friends,
        builder: (context, friends) {
          if (loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (friends.length == 0) {
            return Center(
              child: Text(args.type == 'follow'
                  ? 'User is not subscribed to anyone!'
                  : 'No subscribers yet!'),
            );
          }

          return Container(
            child: StoreConnector<AppState, String>(
              converter: (store) => store.state.error,
              builder: (context, error) {
                return Stack(
                  children: [
                    ListView.builder(
                      itemCount: friends.length,
                      itemBuilder: (context, i) =>
                          FriendsListCard(user: friends[i]),
                    ),
                    error != null ? ErrorWindow() : SizedBox(),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class FriendsScreenArgs {
  String userId;
  String type;
  FriendsScreenArgs({this.userId, this.type});
}
