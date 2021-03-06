import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ssn/actions/people_actions.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/user.dart';
import 'package:ssn/widgets/error_window.dart';
import 'package:ssn/widgets/nav_drawer.dart';
import 'package:ssn/widgets/people_list.dart';

class PeopleScreen extends StatefulWidget {
  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  bool loading = true;
  void setLoading() => setState(() => loading = !loading);

  @override
  Widget build(BuildContext context) {
    if (loading) {
      Store<AppState> store = StoreProvider.of(context);
      Function getAllPeople = getAllPeopleAction(setLoading);
      store.dispatch(getAllPeople(store));
    }
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("SSN"),
      ),
      body: StoreConnector<AppState, String>(
        converter: (store) => store.state.error,
        builder: (context, error) {
          return Stack(
            children: [
              StoreConnector<AppState, List<User>>(
                converter: (store) => store.state.people,
                builder: (context, people) {
                  if (loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return PeopleList(people: people);
                },
              ),
              error != null ? ErrorWindow() : SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
