import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
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

ThunkAction<AppState> getAllPeopleAction() {
  return (Store<AppState> store) async {
    final response = await UserApi.getAllUsers();
    store.dispatch(SetAllUsers(
        people: List.from(
            response['users'].map((user) => User.fromMap(user)).toList())));
  };
}

ThunkAction<AppState> getUserDataByIdAction(userId) {
  return (Store<AppState> store) async {
    final response = await UserApi.getUserDataById(userId);
    store.dispatch(SetOneUser(user: User.fromMap(response['user'])));
  };
}
