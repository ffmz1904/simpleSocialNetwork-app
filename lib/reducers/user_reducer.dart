import 'package:redux/redux.dart';
import 'package:ssn/actions/user_actions.dart';

Reducer<Map<String, dynamic>> userReducer = combineReducers([
  TypedReducer<Map<String, dynamic>, SetUserData>(setUserData),
  TypedReducer<Map<String, dynamic>, RemoveUserData>(removeUserData),
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
