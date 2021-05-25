import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:ssn/actions/post_actions.dart';
import 'package:ssn/app_state.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _body = TextEditingController();

  Future createPost(context) async {
    print('ok');
    Store<AppState> store = StoreProvider.of(context);
    Function create = createPostAction(_title.text, _body.text);
    store.dispatch(create(store));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SSN"),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.arrowLeft,
            size: 16,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView(children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              children: [
                TextField(
                  controller: _title,
                  maxLines: 3,
                  decoration: InputDecoration(
                      hintText: 'Title ...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5.0),
                      )),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _body,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: 'Text ...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5.0),
                      )),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () => createPost(context).whenComplete(
                      () => Navigator.pushNamed(context, "/profile")),
                  child: Text('Create'),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
