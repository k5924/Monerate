import 'dart:convert';

import 'package:http/http.dart' as http;

/// This class lets us communicate with external APIs
class ExternalAPIProvider {
  /// This field will store the base url of the api
  final String url;

  /// This field will store the endpoint to use with the api
  final String endPoint;

  /// This field will store all the headers required to use that api endpoint
  final Map<String, String>? headers;

  /// This field will store all the parameters required to use that api endpoint
  final Map<String, String>? parameters;

  /// This field will store the request body if its required by the endpoint
  final String? body;

  /// This constructor requires we supply all of these parameters to use this class
  ExternalAPIProvider({
    required this.url,
    required this.endPoint,
    required this.parameters,
    required this.headers,
    required this.body,
  });

  /// This method makes a post request with the data supplied and either returns the correct data or an integer error code
  Future postData() async {
    final http.Response response =
        await http.post(Uri.https(url, endPoint), headers: headers, body: body);
    if (response.statusCode == 200) {
      final String data = response.body;
      final decodedData = jsonDecode(data);
      return decodedData;
    } else {
      return response.statusCode;
    }
  }

  /// This method makes a get request with the data supplied and either returns the correct data or an integer error code
  Future getData() async {
    final http.Response response =
        await http.get(Uri.https(url, endPoint, parameters), headers: headers);
    if (response.statusCode == 200) {
      final String data = response.body;
      final decodedData = jsonDecode(data);
      return decodedData;
    } else {
      return response.statusCode;
    }
  }
}
