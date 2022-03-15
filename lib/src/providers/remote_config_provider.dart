import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';

class RemoteConfigProvider {
  final FirebaseRemoteConfig remoteConfig;

  RemoteConfigProvider({required this.remoteConfig});

  Future<FirebaseRemoteConfig?> _initialise() async {
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await remoteConfig.fetchAndActivate();
      return remoteConfig;
    } on PlatformException catch (exception) {
      // Fetch exception.
      print(exception);
    } catch (exception) {
      print(
        'Unable to fetch remote config. Cached or default values will be '
        'used',
      );
      print(exception);
    }
    return null;
  }

  Future<String> getYahooFinanceAPIKey() async {
    final remoteConfig = await _initialise();
    return remoteConfig!.getString('yahoo_finance_api_key');
  }

  Future<Set<String>> getPlaidKeys() async {
    final remoteConfig = await _initialise();
    final devKey = remoteConfig!.getString('plaid_dev_key');
    final sandboxKey = remoteConfig.getString('plaid_sandbox_key');
    final clientId = remoteConfig.getString('plaid_client_id');
    return {devKey, sandboxKey, clientId};
  }
}
