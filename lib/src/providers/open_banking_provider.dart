// ignore_for_file: avoid_dynamic_calls

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:monerate/src/providers/export.dart';

class OpenBankingProvider {
  final RemoteConfigProvider remoteConfigProvider =
      RemoteConfigProvider(remoteConfig: FirebaseRemoteConfig.instance);
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);
  final String url = 'sandbox.plaid.com';
  late List<String> apiKeys;

  Future<void> getAPIKeys() async {
    apiKeys = await remoteConfigProvider.getPlaidKeys();
  }

  Future getLinkToken() async {
    await getAPIKeys();
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

  Future getAccessToken(String publicToken) async {
    await getAPIKeys();
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

  Future getAccounts(String accessToken) async {
    await getAPIKeys();
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
