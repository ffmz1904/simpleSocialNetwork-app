import 'package:redux/redux.dart';
import 'package:ssn/actions/user_actions.dart';

Reducer<Map<String, dynamic>> userReducer = combineReducers([
  TypedReducer<Map<String, dynamic>, SetUserData>(setUserData),
  TypedReducer<Map<String, dynamic>, RemoveUserData>(removeUserData),
  TypedReducer<Map<String, dynamic>, UpdateUserFriends>(updateFriendsList),
  TypedReducer<Map<String, dynamic>, UpdateUserProfile>(updateUserProfile),
]);

Map<String, dynamic> setUserData(
  Map<String, dynamic> user,
  SetUserData action,
) {
  return {'isAuth': action.data['isAuth'], 'data': action.data['user']};
}

Map<String, dynamic> removeUserData(
  Map<String, dynamic> user,
  RemoveUserData action,
) {
  return {'isAuth': false, 'data': {}};
}

Map<String, dynamic> updateFriendsList(
  Map<String, dynamic> user,
  UpdateUserFriends action,
) {
  return {
    'isAuth': user['isAuth'],
    'data': action.user,
  };
}

Map<String, dynamic> updateUserProfile(
    Map<String, dynamic> user, UpdateUserProfile action) {
  return {'isAuth': user['isAuth'], 'data': action.user};
}
