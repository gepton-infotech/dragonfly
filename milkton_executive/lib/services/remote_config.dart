import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  RemoteConfig remoteConfig = RemoteConfig.instance;
  void setupRemoteConfig() async {
    try {
      await remoteConfig.ensureInitialized();
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      rethrow;
    }
  }

  String get prodURL => remoteConfig.getString('prod_url');
  String get apiKey => remoteConfig.getString('api_key');
}
