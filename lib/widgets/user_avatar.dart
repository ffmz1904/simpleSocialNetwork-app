import 'package:flutter/material.dart';
import 'package:ssn/constants.dart';

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
      backgroundImage: NetworkImage(SERVER_URL + url),
    );
  }
}
