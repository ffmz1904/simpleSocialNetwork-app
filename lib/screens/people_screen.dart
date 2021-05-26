import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ssn/actions/people_actions.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/user.dart';
import 'package:ssn/widgets/nav_drawer.dart';
import 'package:ssn/widgets/people_list.dart';

class PeopleScreen extends StatefulWidget {
  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  bool loading = true;

  Future getPeople(store) async {
    Function getAllPeople = getAllPeopleAction();
    store.dispatch(getAllPeople(store));
  }

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of(context);
    getPeople(store).whenComplete(() => setState(() => loading = false));

    if (loading) {
      return Text('Loading ...');
    }

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("SSN"),
      ),
      body: StoreConnector<AppState, List<User>>(
        converter: (store) => store.state.people,
        builder: (context, people) {
          return PeopleList(people: people);
        },
      ),
    );
  }
}
