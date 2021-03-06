import 'package:flutter/material.dart';
import 'package:ssn/models/user.dart';
import 'package:ssn/screens/profile_screen.dart';
import 'package:ssn/widgets/user_avatar.dart';

class PeopleListItem extends StatelessWidget {
  final User user;

  PeopleListItem({this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/profile",
          arguments: ProfileScreenArgs(userId: user.id)),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              offset: Offset(3, 3),
              blurRadius: 5,
            ),
            BoxShadow(
              color: Colors.grey[300],
              offset: Offset(-3, 3),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserAvatar(
              url: user.image,
              radius: 50,
            ),
            SizedBox(
              height: 15,
            ),
            Text(user.name, style: TextStyle(fontSize: 18))
          ],
        ),
      ),
    );
  }
}
