import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';

/// This class lets us interact with firebase remote config
class RemoteConfigProvider {
  /// This field will store an instance of firebase remote config
  final FirebaseRemoteConfig remoteConfig;

  /// This constructor requires us to inject an instance of firebase remote config before using this class
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

  /// This method retrieves the yahoo finance developer api keys from firebase remote config
  Future<String> getYahooFinanceAPIKey() async {
    final remoteConfig = await _initialise();
    return remoteConfig!.getString('yahoo_finance_api_key');
  }

  /// This method retrieves the plaid developer api keys from firebase remote config
  Future<List<String>> getPlaidKeys() async {
    final remoteConfig = await _initialise();
    final devKey = remoteConfig!.getString('plaid_dev_key');
    final sandboxKey = remoteConfig.getString('plaid_sandbox_key');
    final clientId = remoteConfig.getString('plaid_client_id');
    return [devKey, sandboxKey, clientId];
  }
}
