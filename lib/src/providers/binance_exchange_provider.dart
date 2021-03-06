// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';

/// This class lets us interact with the binance cryptocurrency exchange
class BinanceExchangeProvider {
  /// This variable stores the base url for binances api
  final String url = "api.binance.com";

  /// This variable stores an instance of auth provider
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  /// This variable stores an instance of box provider
  final BoxProvider boxProvider = BoxProvider();

  String _hmacSha256({
    required String query,
    required String secret,
  }) {
    final key = utf8.encode(secret);
    final msg = utf8.encode(query);
    final hmac = Hmac(sha256, key);
    final signature = hmac.convert(msg).toString();

    return signature;
  }

  /// This method writes the supplied secret and public api key to an encrypted hive box
  Future writeKeys({
    required String secret,
    required String apiKey,
  }) async {
    final result = await getBalances(
      secret: secret,
      apiKey: apiKey,
    );
    if (result != "error") {
      final box = await boxProvider.getKeys();
      final keys = LocalKeyModel(
        provider: 'binance',
        keys: [
          apiKey,
          secret,
        ],
      );
      box.add(keys);
      box.close();
    }
    return result;
  }

  /// This method reads api keys from the encrypted hive box
  Future<LocalKeyModel?>? getKeys() async {
    final box = await boxProvider.getKeys();
    final keys = box.get('binance');
    return keys;
  }

  /// This method gets a users balances from binance using the users secret and public api keys
  Future getBalances({
    required String secret,
    required String apiKey,
  }) async {
    final String timestamp = "${DateTime.now().millisecondsSinceEpoch}";
    final String signature = _hmacSha256(
      query: 'timestamp=$timestamp',
      secret: secret,
    );
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
      body: null,
    );
    final cryptoBalances = await externalAPIProvider.getData();
    if (cryptoBalances.runtimeType == int) {
      return "error";
    } else {
      cryptoBalances['balances'].forEach((element) async {
        if (element['free'] != null &&
            element['locked'] != null &&
            element['asset'] != null) {
          if (0 <
              (double.parse(element['free'].toString()) +
                  double.parse(element['locked'].toString()))) {
            final result2 = await authProvider.addFinanceAccount(
              name: element['asset'].toString(),
              symbol: 'Binance',
              type: "Cryptocurrency",
              amount: (double.parse(element['free'].toString()) +
                      double.parse(element['locked'].toString()))
                  .toString(),
              price: '',
            );
            if (result2 != null) {
              return result2;
            }
          }
        }
      });
    }
  }
}
