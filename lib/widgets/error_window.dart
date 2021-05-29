import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:ssn/actions/error_action.dart';
import 'package:ssn/app_state.dart';

class ErrorWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of(context);

    return StoreConnector<AppState, String>(
      converter: (store) => store.state.error,
      builder: (context, message) {
        return AlertDialog(
          title: const Text(
            'Error!',
            textAlign: TextAlign.center,
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => store.dispatch(RemoveError()),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
