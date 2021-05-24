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

  static Future getUserDataById(id) async {
    Map response = await Api.get(endpoint: apiBaseUri + id).request();
    return response;
  }
}
