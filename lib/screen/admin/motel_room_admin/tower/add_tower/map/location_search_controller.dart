import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gohomy/utils/base/base_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'goong_sdk_repository.dart';

class LocationSearchController extends GetxController {
  final _state = BaseState().obs;

  BaseState get state => _state.value;

  final TextEditingController searchController = TextEditingController();

  Future<void> getSearchResult({LatLng? destination}) async {
    try {
      _state.value = BaseState.loading();

      _state.value = BaseState.loaded(
        await GoongSDKRepository().placeSearchAutoComplete(
          input: searchController.text,
          destination: destination,
        ),
      );
    } catch (e, stackTrace) {
      log(
        e.toString(),
        stackTrace: stackTrace,
        name: 'LocationSearchController - getSearchResult',
      );

      _state.value = BaseState.error(e.toString());
    }
  }
}
