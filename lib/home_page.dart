import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_google_map/my_button_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LatLng? currentPosition;
  GoogleMapController? myMapController;
  final Set<Marker> _markers = {};
  static const LatLng _mainLocation = LatLng(36.317093, 59.517183);

  void _getUserLocation() async {
    //Get location permission
    await Geolocator.requestPermission();

    //Get current location
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  //Fixed market location
  Set<Marker> myMarker() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_mainLocation.toString()),
        position: _mainLocation,
        infoWindow: const InfoWindow(
          title: 'Historical City',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    return _markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bokafix Case Study'),
        backgroundColor: const Color(0xFF2EC1EF),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          //Map widget
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _mainLocation,
              zoom: 10.0,
            ),
            markers: myMarker(),
            mapType: MapType.normal,
            onMapCreated: (controller) {
              setState(() {
                myMapController = controller;
              });
            },
          ),

          //Buttons
          Positioned(
            bottom: 16,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  //Move to random location button
                  SizedBox(
                    width: 155,
                    height: 45,
                    child: MyButton(
                        title: 'Teleport me to somewhere random',
                        buttonColor: const Color(0xFF2EC1EF),
                        onPressed: () {
                          //Back to main location
                          setState(() {
                            myMapController?.animateCamera(
                              CameraUpdate.newCameraPosition(
                                const CameraPosition(
                                  target: _mainLocation,
                                ),
                              ),
                            );
                          });
                        }),
                  ),

                  //Space
                  const SizedBox(
                    height: 16,
                  ),

                  //Move to home button
                  SizedBox(
                    width: 155,
                    height: 45,
                    child: MyButton(
                      title: 'Bring me back home',
                      buttonColor: const Color(0xFF9A2EEF),
                      onPressed: () async {
                        //Get current position and change the camera position
                        _getUserLocation();
                        setState(() {
                          //Set new marker
                          _markers.add(Marker(
                            markerId: const MarkerId(
                              'current_location',
                            ),
                            position: currentPosition!,
                            infoWindow: const InfoWindow(
                              title: 'Current Position',
                            ),
                            icon: BitmapDescriptor.defaultMarker,
                          ));

                          //Move camera to current location
                          myMapController?.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: currentPosition!,
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
