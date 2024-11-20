import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_domestic_violence/app/components/button_component.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  late GoogleMapController mapController;

  final List<LatLng> _locations = [
    LatLng(15.9752603, 108.253227),
    LatLng(15.987235, 108.264547),
    LatLng(16.012345, 108.212345),
    LatLng(16.050000, 108.200000),
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showShareModal(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Share Location",
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
              Icons.share,
              size: 28,
              color: ColorData.colorIcon,
            ),
            onPressed: () {
              _showShareModal(context);
            },
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

void _showShareModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.80,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 112, 112, 112),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 10),
              // Tiêu đề
              Text(
                textAlign: TextAlign.left,
                "Set the duration to your live sharing",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "30 min",
                        style: TextStyle(
                          color: ColorData.colorSos,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "2 hour",
                        style: TextStyle(color: ColorData.colorText),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "4 hour",
                        style: TextStyle(color: ColorData.colorText),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Turn Off",
                        style: TextStyle(color: ColorData.colorText),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              Text(
                "Select contact to share your live location with",
                textAlign: TextAlign.left,
                style: TextStyle(),
              ),
              Row(
                children: [
                  Text("Select all"),
                  Radio(
                    onChanged: (value) {},
                    value: false,
                    groupValue: null,
                  ),
                ],
              ),
              SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(
                          "SOS",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text("Sikandar"),
                      subtitle: Text("089546987"),
                      trailing: Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          value: false,
                          onChanged: (value) {
                            //
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              ButtonComponent(
                text: "Share Location",
                onPress: () {
                  //
                  Get.toNamed(Routes.sharelocationview);
                },
                width: 350,
                backgroundColor: ColorData.colorSos,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      );
    },
  );
}
