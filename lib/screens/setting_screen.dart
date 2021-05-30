import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:ssn/actions/user_actions.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/user.dart';
import 'package:ssn/widgets/error_window.dart';
import 'package:ssn/widgets/nav_drawer.dart';
import 'package:ssn/widgets/user_avatar.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPass = TextEditingController();
  TextEditingController _oldPass = TextEditingController();

  File _image;
  final picker = ImagePicker();

  Future getImage(type) async {
    final pickedFile = await picker.getImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future updateProfile(store) async {
    Map<String, dynamic> params = {
      'name': _name.text,
      'email': _email.text,
    };

    if (_password.text != '') {
      if (_password.text == _confirmPass.text) {
        params
            .addAll({'password': _password.text, 'oldPassword': _oldPass.text});
      }
    }

    if (_image != null) {
      params.addAll(
          {'img': await MultipartFile.fromFile(_image.path, filename: 'img')});
    }

    FormData formData = new FormData.fromMap(params);
    Function update = updateProfileAction(formData);
    store.dispatch(update(store));
    Navigator.pushNamed(context, "/profile");
  }

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("SSN"),
      ),
      drawer: NavDrawer(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: StoreConnector<AppState, String>(
          converter: (store) => store.state.error,
          builder: (context, error) {
            return Stack(
              children: [
                StoreConnector<AppState, User>(
                  converter: (store) => store.state.user['data'],
                  builder: (context, user) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: ListView(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                _image != null
                                    ? CircleAvatar(
                                        backgroundImage: FileImage(_image),
                                        radius: 50,
                                      )
                                    : UserAvatar(
                                        url: user.image,
                                        radius: 50,
                                      ),
                                TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            _buildPopupDialog(context),
                                      );
                                    },
                                    child: Text('Change image')),
                              ],
                            ),
                          ),
                          _userDataForm(user.name, user.email),
                          _userChangePassForm(),
                          Center(
                            child: ElevatedButton(
                              child: Text('Save'),
                              onPressed: () => updateProfile(store),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                error != null ? ErrorWindow() : SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _input(controller, hint, obsecure) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: TextField(
        controller: controller,
        obscureText: obsecure,
        decoration: InputDecoration(
          hintText: hint,
        ),
      ),
    );
  }

  Widget _userDataForm(name, email) {
    _name.text = name;
    _email.text = email;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Change profile data:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          _input(_name, 'Name ...', false),
          _input(_email, 'Email ...', false),
        ],
      ),
    );
  }

  Widget _userChangePassForm() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Change password:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          _input(_password, 'New password ...', true),
          _input(_confirmPass, 'Confirm new password ...', true),
          _input(_oldPass, 'Old password ...', true),
        ],
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'Get image from:',
        textAlign: TextAlign.center,
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextButton(
              onPressed: () => getImage('camera'),
              child: Text(
                'Camera',
                style: TextStyle(fontSize: 20),
              )),
          TextButton(
            onPressed: () => getImage('galery'),
            child: Text(
              'Galery',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
