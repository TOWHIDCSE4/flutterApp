import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart' as loc;
import 'package:get/get.dart';
import 'package:gohomy/const/color.dart';
import 'package:google_api_headers/google_api_headers.dart' as header;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;

import 'direction_model.dart';
import 'direction_repository.dart';

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
    target: LatLng(21.0278, 105.2342),
    zoom: 11.5,
  );

  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _info;
  final Map<String, Marker> _markers = {};
  GoogleMapController? _controller;
  final TextEditingController locationController = TextEditingController();

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
                primary: Colors.green,
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
                primary: Colors.blue,
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
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_markers['myLocation']!= null) _markers['myLocation']!,
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
          ),
          Positioned(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(.8),
                  ),
                  width: 300,
                  child: TextField(
                    controller: locationController,
                    onTap: _handleSearch,
              
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: "Enter the location",
                        hintStyle: TextStyle(color: AppColor.dark0, fontSize: 18, fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)))),
                  ),
              
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController?.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
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
    places.Prediction? p = await loc.PlacesAutocomplete.show(
        context: context,
        apiKey: 'AIzaSyAqTbnMzItUekvEqmF8VmF1PXrqNKoFsDQ',
        onError: onError, // call the onError function below
        mode: loc.Mode.fullscreen,
        language: 'en', //you can set any language for search
        strictbounds: false,
        types: [],
        decoration: const InputDecoration(
          hintText: 'search',
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(20),
          //   borderSide: const BorderSide(color: Colors.white),
          // ),
        ),
        components: [] // you can determine search for just one country
        );

    displayPrediction(p!);
    String address =  p.description.toString();
    locationController.text = address;
    Future.delayed(const Duration(seconds: 1), () {
      // Get.back();
      widget.selectedAddress(address);
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
      apiKey: 'AIzaSyAqTbnMzItUekvEqmF8VmF1PXrqNKoFsDQ',
      apiHeaders: await const header.GoogleApiHeaders().getHeaders(),
    );
    places.PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
// detail will get place details that user chose from Prediction search
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    _markers.clear(); //clear old marker and set new one
    final marker = Marker(
      markerId: const MarkerId('deliveryMarker'),
      position: LatLng(lat, lng),
      infoWindow: const InfoWindow(
        title: '',
      ),
    );
    setState(() {
      _markers['myLocation'] = marker;
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 15),
        ),
      );
    });
  }
}
