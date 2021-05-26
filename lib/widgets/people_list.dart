import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/user.dart';
import 'package:ssn/widgets/people_list_item.dart';

class PeopleList extends StatelessWidget {
  List<User> people;

  PeopleList({this.people});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: StoreConnector<AppState, Map<String, dynamic>>(
        converter: (store) => store.state.user,
        builder: (context, authUser) {
          if (authUser['isAuth']) {
            people =
                people.where((user) => user.id != authUser['data'].id).toList();
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: people.length,
            itemBuilder: (context, i) {
              return PeopleListItem(user: people[i]);
            },
          );
        },
      ),
    );
  }
}
