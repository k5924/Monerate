// ignore_for_file: avoid_dynamic_calls

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:monerate/src/providers/export.dart';

/// This class lets us interact with Plaids API
class OpenBankingProvider {
  /// This variable stores an instance of firebase remote config
  final RemoteConfigProvider remoteConfigProvider =
      RemoteConfigProvider(remoteConfig: FirebaseRemoteConfig.instance);

  /// This variable stores an instance of AuthProvider
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  /// This variable stores the base url for the plaid api
  final String url = 'sandbox.plaid.com';

  /// This variable will store the api keys we retrieve from firebase remote config
  late List<String> apiKeys;

  Future<void> _getAPIKeys() async {
    apiKeys = await remoteConfigProvider.getPlaidKeys();
  }

  /// This method retrieves the link token from plaids api after exchanging our api keys
  Future getLinkToken() async {
    await _getAPIKeys();
    final userID = await authProvider.getUID();
    final ExternalAPIProvider externalAPIProvider = ExternalAPIProvider(
      url: url,
      endPoint: '/link/token/create',
      parameters: null,
      headers: {
        'Content-Type': 'application/json',
      },
      body:
          '{ "client_id": "${apiKeys[2]}", "secret": "${apiKeys[1]}", "user": { "client_user_id": "$userID" },"client_name": "Monerate", "products": ["auth"], "country_codes": ["GB"], "language": "en", "webhook": "https://sample-web-hook.com", "account_filters": { "depository": { "account_subtypes": ["all"] } } }',
    );
    final data = await externalAPIProvider.postData();
    if (data.runtimeType == int) {
      return "error";
    } else {
      return data["link_token"].toString();
    }
  }

  /// This method exchanges the publick token we receieve after entering our account details for an access token
  Future getAccessToken({
    required String publicToken,
  }) async {
    await _getAPIKeys();
    final ExternalAPIProvider externalAPIProvider = ExternalAPIProvider(
      url: url,
      endPoint: '/item/public_token/exchange',
      parameters: null,
      headers: {
        'Content-Type': 'application/json',
      },
      body:
          '{ "client_id": "${apiKeys[2]}", "secret": "${apiKeys[1]}", "public_token": "$publicToken"}',
    );
    final data = await externalAPIProvider.postData();
    if (data.runtimeType == int) {
      return "error";
    } else {
      return data["access_token"].toString();
    }
  }

  /// This method retrieves the users account balances using the supplied access token
  Future getAccounts({
    required String accessToken,
  }) async {
    await _getAPIKeys();
    final ExternalAPIProvider externalAPIProvider = ExternalAPIProvider(
      url: url,
      endPoint: '/accounts/get',
      parameters: null,
      headers: {
        'Content-Type': 'application/json',
      },
      body:
          '{ "client_id": "${apiKeys[2]}", "secret": "${apiKeys[1]}", "access_token": "$accessToken"}',
    );
    final data = await externalAPIProvider.postData();
    print(data);
    if (data.runtimeType == int) {
      print(data.toString());
      return "error";
    } else {
      return data;
    }
  }
}
