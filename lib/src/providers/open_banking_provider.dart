import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:monerate/src/providers/export.dart';

class OpenBankingProvider {
  final RemoteConfigProvider remoteConfigProvider =
      RemoteConfigProvider(remoteConfig: FirebaseRemoteConfig.instance);
  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  late List<String> apiKeys;

  Future<void> getAPIKeys() async {
    apiKeys = await remoteConfigProvider.getPlaidKeys();
  }

  Future getLinkToken() async {
    await getAPIKeys();
    final userID = await authProvider.getUID();
    final ExternalAPIProvider externalAPIProvider = ExternalAPIProvider(
      url: 'sandbox.plaid.com',
      endPoint: '/link/token/create',
      parameters: null,
      headers: {
        'Content-Type': 'application/json',
      },
      body:
          '{ "client_id": "${apiKeys[2]}", "secret": "${apiKeys[2]}", "user": { "client_user_id": "$userID" },"client_name": "Monerate", "products": ["auth"], "country_codes": ["GB"], "language": "en", "webhook": "https://sample-web-hook.com", "account_filters": { "depository": { "account_subtypes": ["checking"] } } }',
    );
    final data = await externalAPIProvider.postData();
    if (data.runtimeType == int) {
      return "error";
    } else {
      return data["link_token"];
    }
  }
}
