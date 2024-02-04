import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfig {
  final remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteConfig.setDefaults(const {
      "prod_url": "https://milkton.gepton.in/v2/",
    });
    await remoteConfig.fetchAndActivate();
  }

  String get prodURL => remoteConfig.getString('multitenant_prod_url');
}
