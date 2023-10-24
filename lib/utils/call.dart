import 'package:url_launcher/url_launcher.dart';

class Call {
  static Future<void> call(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
