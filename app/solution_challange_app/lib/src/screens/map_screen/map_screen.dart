import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solution_challange_app/src/constants.dart';
import 'package:solution_challange_app/src/models/business_account.dart';
import 'package:solution_challange_app/src/services/business_account_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  List<BusinessAccount> restaurants = [];

  void _onMapCreated(
    GoogleMapController controller,
  ) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BusinessAccount>>(
      future: BusinessAccountService(baseUrl: BASE_URL).getAllBusinessAccounts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(39.925533, 32.866287), zoom: 12));
        } else if (snapshot.hasError) {
          return const GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(39.925533, 32.866287), zoom: 12));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(39.925533, 32.866287), zoom: 12));
        } else {
          restaurants = snapshot.data!;
          for (final restaurant in restaurants) {
            markers.add(Marker(
              markerId: MarkerId(restaurant.id),
              position: LatLng(restaurant.latitude, restaurant.longitude),
              infoWindow: InfoWindow(
                title: restaurant.name,
                onTap: () {
                  Navigator.pushNamed(context, "/display-restaurant",
                      arguments: restaurant);
                },
              ),
            ));
          }
          return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
                target: LatLng(39.925533, 32.866287), zoom: 12),
            markers: markers,
          );
        }
      },
    );
  }
}
