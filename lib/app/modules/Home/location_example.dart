import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationExample extends StatefulWidget {
  @override
  _LocationExampleState createState() => _LocationExampleState();
}

class _LocationExampleState extends State<LocationExample> {
  String _currentAddress = "";
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Kiểm tra quyền truy cập vị trí
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        // Quyền truy cập bị từ chối vĩnh viễn
        setState(() {
          _errorMessage =
              "Location permissions are permanently denied. Please enable them in app settings.";
        });
        return;
      }

      // Lấy vị trí hiện tại
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Chuyển đổi vĩ độ và kinh độ thành địa chỉ
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        _currentAddress =
            "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
        print(_currentAddress);
        // In ra tọa độ để kiểm tra
        print(
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}");
      } else {
        _currentAddress = "No address found";
      }

      setState(() {});
    } catch (e) {
      print(e);
      setState(() {
        _errorMessage = "Error: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Current Location")),
      body: Center(
        child: Text(
          _errorMessage.isNotEmpty
              ? _errorMessage
              : _currentAddress.isEmpty
                  ? "Getting location..."
                  : _currentAddress,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
