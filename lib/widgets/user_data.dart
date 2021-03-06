import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/user.dart';
import 'package:ssn/screens/friends_screen.dart';
import 'package:ssn/widgets/friend_button.dart';
import 'package:ssn/widgets/user_avatar.dart';

class UserData extends StatelessWidget {
  final String userId;
  final bool authUser;

  UserData({this.userId, this.authUser});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, User>(
      converter: (store) => authUser
          ? store.state.user['data']
          : store.state.people
              .where((user) => user.id == userId)
              .toList()
              .first,
      builder: (context, user) {
        return Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.grey[300], offset: Offset(0, 3), blurRadius: 4),
          ]),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(
                radius: 50,
                url: user.image,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(user.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, "/friends",
                                  arguments: FriendsScreenArgs(
                                      userId: userId, type: 'follow')),
                              child: Text('Follow: ${user.follow.length}')),
                          SizedBox(width: 20),
                          TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, "/friends",
                                  arguments: FriendsScreenArgs(
                                      userId: userId, type: 'subscribers')),
                              child: Text(
                                  'Subscribers: ${user.subscribers.length}')),
                        ],
                      ),
                      SizedBox(height: 14),
                      StoreConnector<AppState, Map<String, dynamic>>(
                          converter: (store) => store.state.user,
                          builder: (context, authUser) {
                            if (authUser['isAuth'] &&
                                authUser['data'].id != user.id) {
                              return FriendButton(
                                  user: authUser['data'], friendId: user.id);
                            }
                            return SizedBox();
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
