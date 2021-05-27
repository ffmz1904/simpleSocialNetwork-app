import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ssn/actions/people_actions.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/user.dart';
import 'package:ssn/widgets/friends_list_card.dart';
import 'package:ssn/widgets/nav_drawer.dart';

class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  bool loading = true;

  Future getFriends(store, args) async {
    Function loadFriendsData = getUserFriendsAction(args.userId, args.type);
    store.dispatch(loadFriendsData(store));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as FriendsScreenArgs;
    Store<AppState> store = StoreProvider.of(context);

    if (loading) {
      getFriends(store, args)
          .whenComplete(() => setState(() => loading = false));
      return Text('Loading ...');
    }

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("SSN"),
      ),
      body: StoreConnector<AppState, List<User>>(
        converter: (store) => store.state.people,
        builder: (context, friends) {
          if (friends.length == 0) {
            return Center(
              child: Text(args.type == 'follow'
                  ? 'User is not subscribed to anyone!'
                  : 'No subscribers yet!'),
            );
          }

          return Container(
            child: ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, i) => FriendsListCard(user: friends[i]),
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
