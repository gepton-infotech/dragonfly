import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $url');
  }
}
