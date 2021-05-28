import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double radius;
  final String url;

  UserAvatar({
    this.radius,
    @required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage('http://10.0.2.2:4000/' + url),
    );
  }
}
