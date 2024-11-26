// location_provider.dart
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;

class LocationProvider with ChangeNotifier {
  String currentUserPhn = '';
  BitmapDescriptor? _pinLocationIcon;
  BitmapDescriptor? get pinLocationIcon => _pinLocationIcon;
  Map<MarkerId, Marker> _markers = {};
  Map<MarkerId, Marker> get markers => _markers;

  final MarkerId markerId = const MarkerId("1");

  Location _location = Location();
  Location get location => _location;
  LatLng _locationPosition = const LatLng(9.5349730, 76.5888091);
  LatLng get locationPosition => _locationPosition;

  bool locationServiceActive = true;
  StreamSubscription<LocationData>? _locationSubscription;
  GoogleMapController? mapController;

  LatLng? _userLocation;
  LatLng? get userLocation => _userLocation;

  LocationProvider() {
    _location = Location();
    initialization();
  }

  void buildMap(GoogleMapController controller, String prediction) {
    mapController = controller;
    _updateMapMarker(_userLocation, prediction);
  }

  Future<void> initialization() async {
    await getUserLocation();
    await setCustomMapPin();
  }

  Future<void> getUserLocation() async {
    try {
      bool serviceEnabled;
      var permissionGranted =
          await permissionHandler.Permission.location.request();
      if (permissionGranted.isGranted) {
        serviceEnabled = await _location.serviceEnabled();
        if (!serviceEnabled) {
          serviceEnabled = await _location.requestService();
          if (!serviceEnabled) {
            locationServiceActive = false;
            return;
          }
        }
        _locationSubscription?.cancel();
        _locationSubscription =
            _location.onLocationChanged.listen((LocationData currentLocation) {
          _locationPosition =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _userLocation = _locationPosition;
          notifyListeners();
        });
      }
    } catch (e) {
      print('Could not get location: $e');
    }
  }

  Future<void> setCustomMapPin() async {
    _pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      'assets/marker.png',
    );
  }

  void _updateMapMarker(LatLng? location, String prediction) {
    if (location != null) {
      final marker = Marker(
        markerId: markerId,
        position: location,
        icon: _pinLocationIcon!,
        infoWindow: InfoWindow(
          title: 'Prediction: $prediction',
        ),
      );

      _markers[markerId] = marker;
      notifyListeners();
    }
  }
}
