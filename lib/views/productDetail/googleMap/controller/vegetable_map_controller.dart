import 'dart:async';
import 'package:fresh_picked/core/app_export.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../../dashboard/controller/dashboard_controller.dart';

class VegetableMapController extends GetxController {
  final Completer<GoogleMapController> mapController = Completer();
  Rx<Position?> currentPosition = Rx<Position?>(null);
  var markers = <Marker>{}.obs;
  var polylines = <Polyline>{}.obs;
  final DashboardController dashboardController = Get.find<DashboardController>();

  @override
  void onInit() {
    super.onInit();
    _getUserLocation();
    _loadVegetableMarkers();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Location Error", "Enable location services");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Permission Denied", "Allow location access");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Permission Denied", "Go to settings to enable location access");
      return;
    }


    currentPosition.value = await Geolocator.getCurrentPosition();
    if (currentPosition.value != null) {
      _addMarker(
        LatLng(currentPosition.value!.latitude, currentPosition.value!.longitude),
        "Your Location",
      );
    }
  }

  /// Iterates over the products list from DashboardController and adds markers.
  void _loadVegetableMarkers() {
    // Ensure the products list is not empty
    for (var product in dashboardController.productsList) {
      // Ensure that the product's location is available with valid coordinates
      if (product.location != null &&
          product.location!.coordinates != null &&
          product.location!.coordinates!.length >= 2) {
        // Assuming GeoJSON order: [longitude, latitude]
        double longitude = product.location!.coordinates![0];
        double latitude = product.location!.coordinates![1];

        _addMarker(
          LatLng(latitude, longitude),
          product.name ?? "Vegetable",
        );
      }
    }
  }

  /// Adds a marker to the markers set.
  void _addMarker(LatLng position, String title) {
    markers.add(
      Marker(
        markerId: MarkerId(title),
        position: position,
        infoWindow: InfoWindow(title: title),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
  }

  Future<void> moveCamera(LatLng position) async {
    final GoogleMapController googleMapController = await mapController.future;
    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(position, 14));
  }

}
