import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class LocationSafeView extends StatefulWidget {
  const LocationSafeView({Key? key}) : super(key: key);

  @override
  _LocationSafeViewState createState() => _LocationSafeViewState();
}

class _LocationSafeViewState extends State<LocationSafeView> {
  late GoogleMapController mapController;

  final List<LatLng> _locations = [
    LatLng(15.9752603, 108.253227),
    LatLng(15.987235, 108.264547),
    LatLng(16.012345, 108.212345),
    LatLng(16.050000, 108.200000),
    LatLng(16.080000, 108.180000),
    LatLng(16.095000, 108.220000),
    LatLng(16.110000, 108.250000),
    LatLng(16.130000, 108.270000),
  ];

  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _addMarkers();
  }

  void _addMarkers() {
    int markerIdCounter = 0;

    for (var location in _locations) {
      final marker = Marker(
        markerId: MarkerId('marker_${markerIdCounter++}'),
        position: location,
        infoWindow: InfoWindow(
          title: 'Marker ${markerIdCounter}',
          snippet: 'Lat: ${location.latitude}, Lng: ${location.longitude}',
        ),
      );

      setState(() {
        _markers.add(marker);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Safe Places",
            style: TextStyle(
              color: ColorData.colorIcon,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 28,
              color: ColorData.colorIcon,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _locations[0],
          zoom: 11.0,
        ),
        markers: _markers,
      ),
    );
  }
}
