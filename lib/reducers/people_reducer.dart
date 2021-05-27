import 'package:redux/redux.dart';
import 'package:ssn/actions/people_actions.dart';
import 'package:ssn/actions/user_actions.dart';
import 'package:ssn/models/user.dart';

Reducer<List<User>> peopleReducer = combineReducers([
  TypedReducer<List<User>, SetAllUsers>(setPeople),
  TypedReducer<List<User>, SetOneUser>(setOneUser),
  TypedReducer<List<User>, UpdateUserFriends>(updateFriendsList),
]);

List<User> setPeople(List<User> people, SetAllUsers action) {
  return action.people;
}

List<User> setOneUser(List<User> people, SetOneUser action) {
  List<String> idList = people.map((user) => user.id).toList();

  if (idList.contains(action.user.id)) {
    return people;
  }

  List<User> peopleList = people + [action.user];
  return peopleList;
}

List<User> updateFriendsList(
  List<User> people,
  UpdateUserFriends action,
) {
  List<User> peopleList = people
      .map((user) => user.id == action.friend.id ? action.friend : user)
      .toList();
  return peopleList;
}
