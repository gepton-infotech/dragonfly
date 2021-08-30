import 'package:milkton_executive/services/remote_config.dart';

RemoteConfigService _remoteConfigService = RemoteConfigService();

String get kExecutiveLoginApiUrl =>
    '${_remoteConfigService.prodURL}executive/login' +
    '?apikey=' +
    _remoteConfigService.apiKey;
String get kGraphQLApiUrl =>
    '${_remoteConfigService.prodURL}api' +
    '?apikey=' +
    _remoteConfigService.apiKey;
