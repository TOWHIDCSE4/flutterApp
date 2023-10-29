import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;

class AutoCompleteSearchResultRepository {
  static const String _baseUrl = 'https://rsapi.goong.io/Place/AutoComplete';

  Future<List<places.Prediction?>> getSearchResult({
    required String input,
    LatLng? destination,
  }) async {
    final response = await Dio().get(
      _baseUrl,
      queryParameters: {
        'input': input,
        if (destination != null)
          'location': '${destination.latitude},${destination.longitude}',
        'api_key': 'Ai9KDd8LhhWLKNgTYectnLlntI60nnh2KZbK6o0K',
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      final predictions = <places.Prediction?>[];

      for (final prediction in response.data['predictions']) {
        predictions.add(places.Prediction.fromJson(prediction));
      }

      return predictions;
    }
    return [];
  }
}
