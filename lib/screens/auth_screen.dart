import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ssn/actions/user_actions.dart';
import 'package:ssn/api/user_api.dart';
import 'package:ssn/app_state.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController name = TextEditingController();

  void setIsLogin() => setState(() => isLogin = !isLogin);

  void submitHandler(store) async {
    if (isLogin) {
      Function login = userLogin(email.text, password.text, context);
      store.dispatch(login(store));
    } else {
      final result =
          await UserApi.registration(name.text, email.text, password.text);
      if (result['success']) {
        Navigator.pushNamed(context, "/auth");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 30, bottom: 20),
          color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pushNamed(context, "/"),
                color: Theme.of(context).accentColor,
              ),
              isLogin ? _loginForm() : _registerForm(),
              Center(
                child: TextButton(
                  onPressed: setIsLogin,
                  child: isLogin
                      ? Text(
                          "No acount? Register!",
                        )
                      : Text("Already have an account? Sign in!"),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "Sign in",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        _input(email, "Email ...", false),
        _input(password, "Password ...", true),
        SizedBox(height: 15),
        _submitBtn()
      ],
    );
  }

  Widget _registerForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            "Registration",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        _input(name, "Name ...", false),
        _input(email, "Email ...", false),
        _input(password, "Password ...", true),
        _input(confirmPassword, "Confirm password ...", true),
        SizedBox(height: 15),
        _submitBtn()
      ],
    );
  }

  Widget _input(controller, hint, obscure) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }

  Widget _submitBtn() {
    return StoreConnector<AppState, VoidCallback>(
      converter: (store) => () => submitHandler(store),
      builder: (context, callback) {
        return ElevatedButton(
          onPressed: callback,
          child: Text(isLogin ? "Enter" : "Register"),
        );
      },
    );
  }
}
