import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';

class RemoteConfigProvider {
  late RemoteConfig remoteConfig;

  Future<RemoteConfig?> initialise() async {
    final remoteConfig = RemoteConfig.instance;
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
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
      print(exception);
    }
  }

  Future<String> getYahooFinanceAPIKey() async {
    final remoteConfig = await initialise();
    return remoteConfig!.getString('yahoo_finance_api_key');
  }
}
