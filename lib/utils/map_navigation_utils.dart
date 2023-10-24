import 'package:url_launcher/url_launcher.dart';

class MapNavigationUtils {
  Future<void> openGoogleMaps(
    String address, {
    double? latitude,
    double? longitude,
  }) async {
    // Encode the address to a URL-friendly format
    final encodedAddress = Uri.encodeComponent(address);

    // Construct the Google Maps URL with the address
    var url = "https://www.google.com/maps/search/?api=1&query=$encodedAddress";

    if (latitude != null && longitude != null) {
      url =
          "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Google Maps';
    }
  }
}
