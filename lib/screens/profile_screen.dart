import 'package:flutter/material.dart';
import 'package:ssn/widgets/nav_drawer.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SSN"),
      ),
      drawer: NavDrawer(),
      body: Text('Profile page'),
    );
  }
}
