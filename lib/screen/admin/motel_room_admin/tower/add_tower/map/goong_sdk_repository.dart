import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;

class GoongSDKRepository {
  static const String _apiKey = 'Ai9KDd8LhhWLKNgTYectnLlntI60nnh2KZbK6o0K';
  static const String _baseUrl = 'https://rsapi.goong.io/';
  static const String _autoComplete = 'Place/AutoComplete';
  static const String _placeDetail = 'Place/Detail';

  Future<List<places.Prediction?>> placeSearchAutoComplete({
    required String input,
    LatLng? destination,
  }) async {
    final response = await Dio(
      BaseOptions(baseUrl: _baseUrl),
    ).get(
      _autoComplete,
      queryParameters: {
        'input': input,
        if (destination != null)
          'location': '${destination.latitude},${destination.longitude}',
        'api_key': _apiKey,
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

  Future<places.PlacesDetailsResponse?> getPlaceDetail(String placeId) async {
    final response = await Dio(
      BaseOptions(baseUrl: _baseUrl),
    ).get(
      _placeDetail,
      queryParameters: {
        'place_id': placeId,
        'api_key': _apiKey,
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      return places.PlacesDetailsResponse.fromJson(response.data);
    }
    return null;
  }
}
