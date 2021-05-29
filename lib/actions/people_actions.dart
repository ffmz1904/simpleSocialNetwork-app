import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:ssn/actions/error_action.dart';
import 'package:ssn/api/user_api.dart';
import 'package:ssn/app_state.dart';
import 'package:ssn/models/user.dart';

class SetAllUsers {
  List<User> people;
  SetAllUsers({this.people});
}

class SetOneUser {
  User user;
  SetOneUser({this.user});
}

ThunkAction<AppState> getAllPeopleAction(cb) {
  return (Store<AppState> store) async {
    final response = await UserApi.getAllUsers();

    if (response['success'] == null) {
      return store.dispatch(SetError(message: response['message']));
    }

    store.dispatch(SetAllUsers(
        people: List.from(
            response['users'].map((user) => User.fromMap(user)).toList())));
    cb();
  };
}
