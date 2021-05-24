import 'dart:convert';

import 'package:http/http.dart' as http;

enum RequestMethod {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
}

class Api {
  final String serverUri = "http://10.0.2.2:4000/";
  String endpoint;
  Map<String, dynamic> body = {};
  RequestMethod method = RequestMethod.GET;

  Api.get({this.endpoint});

  Api.post({this.endpoint, this.body}) : this.method = RequestMethod.POST;

  Api.put({this.endpoint, this.body}) : this.method = RequestMethod.PUT;

  Api.patch({this.endpoint, this.body}) : this.method = RequestMethod.PATCH;

  Api.delete({this.endpoint}) : this.method = RequestMethod.DELETE;

  Future request() async {
    var uri = Uri.parse(this.serverUri + this.endpoint);
    var response;

    switch (method) {
      case RequestMethod.GET:
        response = await http.get(uri);
        break;
      case RequestMethod.POST:
        response = await http.post(uri, body: this.body);
        break;
      case RequestMethod.PUT:
        response = await http.put(uri, body: this.body);
        break;
      case RequestMethod.PATCH:
        response = await http.patch(uri, body: this.body);
        break;
      case RequestMethod.DELETE:
        response = await http.delete(uri);
        break;
    }

    Map<String, dynamic> responseMap = jsonDecode(response.body);
    return responseMap;
  }
}
