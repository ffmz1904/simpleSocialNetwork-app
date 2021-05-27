import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/user.dart';
import 'package:ssn/screens/profile_screen.dart';
import 'package:ssn/widgets/friend_button.dart';

class FriendsListCard extends StatelessWidget {
  final User user;

  FriendsListCard({this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage('http://10.0.2.2:4000/' + user.image),
                ),
                SizedBox(width: 15),
                TextButton(
                  child: Text(
                    user.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () => Navigator.pushNamed(context, "/profile",
                      arguments: ProfileScreenArgs(userId: user.id)),
                ),
              ],
            ),
            StoreConnector<AppState, Map<String, dynamic>>(
              converter: (store) => store.state.user,
              builder: (context, authUser) {
                if (authUser['isAuth'] && user.id != authUser['data'].id) {
                  return FriendButton(
                    user: authUser['data'],
                    friendId: user.id,
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
