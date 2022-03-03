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
    final String timestamp =
        "timestamp=${DateTime.now().millisecondsSinceEpoch}";
    final String query = '' + '&' + timestamp;
    final String signature = _hmacSha256(query, secret);
    final ExternalAPIProvider externalAPIProvider = ExternalAPIProvider(
      url: url,
      endPoint: '/api/v3/account',
      parameters: {
        '?': query,
        '&signature': signature,
      },
      headers: {
        'X-MBX-APIKEY': apiKey,
      },
    );
    final cryptoBalances = await externalAPIProvider.getData();
    if (cryptoBalances.runtimeType == int) {
      return "error";
    } else {
      return cryptoBalances;
    }
  }
}
