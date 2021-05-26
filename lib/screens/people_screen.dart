import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ssn/actions/people_actions.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/user.dart';
import 'package:ssn/widgets/nav_drawer.dart';

class PeopleScreen extends StatelessWidget {
  final Function getAllPeople = getAllPeopleAction();
  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of(context);
    store.dispatch(getAllPeople(store));

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("SSN"),
      ),
      body: StoreConnector<AppState, List<User>>(
        converter: (store) => store.state.people,
        builder: (context, people) {
          print(people);
          return Text('people');
        },
      ),
    );
  }
}
