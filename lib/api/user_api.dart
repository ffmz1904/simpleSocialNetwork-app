import 'package:ssn/api/api.dart';

class UserApi {
  static String apiBaseUri = 'api/user/';

  static Future registration(name, email, password) async {
    Map response = await Api.post(endpoint: apiBaseUri + 'registration', body: {
      "email": email,
      "password": password,
      "name": name,
    }).request();

    return response;
  }

  static Future login(email, password) async {
    Map response = await Api.post(endpoint: apiBaseUri + 'login', body: {
      "email": email,
      "password": password,
    }).request();

    return response;
  }

  static Future checkAuth() async {
    Map response = await Api.get(endpoint: apiBaseUri + 'auth').request();
    return response;
  }

  static Future getAllUsers() async {
    Map response = await Api.get(endpoint: apiBaseUri).request();
    return response;
  }

  static Future subscribe(subscribeTo) async {
    Map response = await Api.post(
        endpoint: apiBaseUri + 'subscribe_request',
        body: {'subscribeTo': subscribeTo}).request();

    return response;
  }

  static Future unsubscribe(unsubscribeId) async {
    Map response = await Api.post(
        endpoint: apiBaseUri + 'unsubscribe',
        body: {'unsubscribedId': unsubscribeId}).request();

    return response;
  }

  static Future getFriends(userId, type) async {
    Map response =
        await Api.get(endpoint: apiBaseUri + 'friends/' + userId + '/' + type)
            .request();
    return response;
  }
}
