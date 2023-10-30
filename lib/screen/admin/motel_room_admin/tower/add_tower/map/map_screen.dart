// import 'dart:developer';
// import 'dart:html';

import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:google_api_headers/google_api_headers.dart' as header;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;

import 'direction_model.dart';
import 'direction_repository.dart';
import 'location_search_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
    required this.selectedAddress,
  }) : super(key: key);
  final Function(String) selectedAddress;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(20.993776, 105.811417),
    zoom: 11.5,
  );

  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _info;
  final Map<String, Marker> _markers = {};
  // GoogleMapController? _controller;
  final TextEditingController locationController = TextEditingController();
  bool isVisibleConfirmBtn = false;

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Google Maps'),
        actions: [
          // if (_origin == null || _destination == null)
          //   IconButton(
          //     onPressed: _handleSearch,
          //     icon: const Icon(Icons.search),
          //   ),
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('ORIGIN'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController?.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('DEST'),
            )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            // myLocationButtonEnabled: false,
            // zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_markers['myLocation'] != null) _markers['myLocation']!,
              if (_origin != null) _origin!,
              if (_destination != null) _destination!,
            },
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _info!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
            onLongPress: _addMarker,
            onTap: onTapMap,
          ),
          Positioned(
              top: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(.8),
                ),
                width: 300,
                child: TextField(
                  controller: locationController,
                  readOnly: true,
                  onTap: _handleSearch,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      hintText: "Enter the location",
                      hintStyle: TextStyle(
                          color: AppColor.dark0,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              )),
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info?.totalDistance}, ${_info?.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          Positioned(
            top: 400,
            right: 10,
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      debugPrint("click");
                      locationController.clear();
                    });
                    _googleMapController?.animateCamera(
                      _info != null
                          ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
                          : CameraUpdate.newCameraPosition(
                              _initialCameraPosition),
                    );
                  },
                  color: Theme.of(context).primaryColor,
                  icon: const Icon(
                    Icons.location_searching,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: isVisibleConfirmBtn
          ? ElevatedButton(
              onPressed: () {
                Get.back();
                log("LOCATION GOOGLE MAPS:${locationController.text}");
                widget.selectedAddress(locationController.text);
              },
              child: const Text('Xác nhận'),
            )
          : null,
    );
  }

  Future<void> onTapMap(info) async {
    final marker = Marker(
      markerId: const MarkerId('deliveryMarker'),
      position: LatLng(info.latitude, info.longitude),
      infoWindow: const InfoWindow(
        title: '',
      ),
    );
    List<Placemark> placemarks =
        await placemarkFromCoordinates(info.latitude, info.longitude);
    setState(() {
      _markers.clear(); //clear old marker and set new one
      _origin = null;
      _destination = null;
      _info = null;
      _markers['myLocation'] = marker;
      _googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(info.latitude, info.longitude),
            zoom: 15,
          ),
        ),
      );
      _googleMapController!.showMarkerInfoWindow(marker.markerId);

      isVisibleConfirmBtn = true;
    });
    // locationController.text = placemarks.map((e) => e.street).toString();
    if (placemarks.isNotEmpty) {
      final street = placemarks.first.street ?? 'street';
      final ward = placemarks.first.subAdministrativeArea ?? 'ward';
      final province = placemarks.first.administrativeArea ?? 'province';
      final country = placemarks.first.country ?? 'country';

      print('address: ${inspect(placemarks[0])}');

      // Format the address
      final formattedAddress =
          '${street.trim()},${ward.trim()}, ${province.trim()}, ${country.trim()}';
      locationController.text = formattedAddress;
      widget.selectedAddress(formattedAddress);
    } else {
      // Handle the case where there are no placemarks.
    }
  }

  void _addMarker(LatLng pos) async {
    setState(() {
      _markers.clear();
      isVisibleConfirmBtn = false;
    });
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin!.position, destination: pos);
      setState(() => _info = directions);
    }
  }

  Future<void> _handleSearch() async {
    places.Prediction? p = await Get.to(() => LocationSearchScreen());
    displayPrediction(p!);
    String address = p.description.toString();
    locationController.text = address;

    setState(() {
      isVisibleConfirmBtn = true;
    });
  }

  void onError(places.PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));
  }

  Future<void> displayPrediction(places.Prediction p) async {
    places.GoogleMapsPlaces _places = places.GoogleMapsPlaces(
      apiKey: 'AIzaSyAu5iRT-pqea9hRWz75BWBU_jyArovw6R0',
      apiHeaders: await const header.GoogleApiHeaders().getHeaders(),
    );
    places.PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
// detail will get place details that user chose from Prediction search
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    _markers.clear(); //clear old marker and set new one
    _origin = null;
    _destination = null;
    final marker = Marker(
      markerId: const MarkerId('deliveryMarker'),
      position: LatLng(lat, lng),
      infoWindow: const InfoWindow(
        title: '',
      ),
    );
    setState(() {
      _markers['myLocation'] = marker;
      _googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 15),
        ),
      );
      isVisibleConfirmBtn = true;
    });
  }
}
