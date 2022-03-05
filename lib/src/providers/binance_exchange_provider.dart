// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:monerate/src/providers/export.dart';

class BinanceExchangeProvider {
  final String url = "api.binance.com";

  String _hmacSha256(String query, String secret) {
    final key = utf8.encode(secret);
    final msg = utf8.encode(query);
    final hmac = Hmac(sha256, key);
    final signature = hmac.convert(msg).toString();

    return signature;
  }

  Future getBalances(String secret, String apiKey) async {
    final String timestamp = "${DateTime.now().millisecondsSinceEpoch}";
    final String signature = _hmacSha256('timestamp=$timestamp', secret);
    final ExternalAPIProvider externalAPIProvider = ExternalAPIProvider(
      url: url,
      endPoint: '/api/v3/account',
      parameters: {
        'timestamp': timestamp,
        'signature': signature,
      },
      headers: {
        'X-MBX-APIKEY': apiKey,
      },
    );
    final cryptoBalances = await externalAPIProvider.getData();
    if (cryptoBalances.runtimeType == int) {
      return "error";
    } else {
      cryptoBalances['balances'].forEach((element) {
        if (element['free'] != null &&
            element['locked'] != null &&
            element['asset'] != null) {
          if (0 <
              (double.parse(element['free'].toString()) +
                  double.parse(element['locked'].toString()))) {
            print(element['asset'] + element['free'] + element['locked']);
          }
        }
      });
    }
  }
}
