import 'package:flutter/material.dart';
import 'package:ssn/widgets/nav_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("SSN"),
      ),
      body: Text('ok'),
    );
  }
}
