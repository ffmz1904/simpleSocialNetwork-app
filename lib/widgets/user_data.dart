import 'package:flutter/material.dart';
import 'package:ssn/models/user.dart';

class UserData extends StatelessWidget {
  final User data;

  UserData({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey[300], offset: Offset(0, 3), blurRadius: 4),
      ]),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('http://10.0.2.2:4000/' + data.image),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(data.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Friends: ${data.friends.length}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
