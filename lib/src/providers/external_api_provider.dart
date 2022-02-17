import 'dart:convert';

import 'package:http/http.dart' as http;

class ExternalAPIProvider {
  final String url;
  final String endPoint;
  final Map<String, String>? headers;
  final Map<String, String>? parameters;

  ExternalAPIProvider({
    required this.url,
    required this.endPoint,
    required this.parameters,
    required this.headers,
  });

  Future postData() async {
    final http.Response response =
        await http.post(Uri.https(url, endPoint), headers: headers);
    if (response.statusCode == 200) {
      final String data = response.body;
      final decodedData = jsonDecode(data);
      return decodedData;
    } else {
      return response.statusCode;
    }
  }

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
