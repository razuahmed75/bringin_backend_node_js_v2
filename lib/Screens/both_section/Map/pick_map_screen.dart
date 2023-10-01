// ignore_for_file: unused_field
import 'package:flutter/material.dart';

// import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
//     as place;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controllers/recruiter_section/map_controll.dart';
import 'dart:async';

const kGoogleApiKey = "AIzaSyC2Uvo-7iIdRIblvQ7ep5VtXpQYPxD_4UQ";

class PickMapScreen extends StatefulWidget {
  const PickMapScreen({super.key});

  @override
  State<PickMapScreen> createState() => _PickMapScreenState();
}

class _PickMapScreenState extends State<PickMapScreen> {
  GoogleMapController? _mapController;
  CameraPosition? _cameraPosition;
  LatLng? _initialPosition;

  final mapcontroll = Get.put(MapControll());

  bool loading = false;

  Future loaddata() async {
    setState(() {
      loading = true;
    });
    await mapcontroll.determinePosition();
    _initialPosition = LatLng(
      mapcontroll.position!.latitude,
      mapcontroll.position!.longitude,
    );
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                // final places = place.FlutterGooglePlacesSdk(kGoogleApiKey);
                // final predictions =
                //     await places.findAutocompletePredictions('Dhaka');
                // print('Result: $predictions');
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition!,
                    zoom: 16,
                  ),
                  minMaxZoomPreference: MinMaxZoomPreference(0, 16),
                  myLocationButtonEnabled: false,
                  onMapCreated: (GoogleMapController mapController) {
                    _mapController = mapController;
                    // if (!widget.fromAddAddress) {
                    //   // Get.find<LocationController>()
                    //   //     .getCurrentLocation(false, mapController: mapController);
                    // }
                  },
                  // scrollGesturesEnabled: !Get.isDialogOpen,
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraMoveStarted: () {
                    // locationController.disableButton();
                  },
                  onCameraIdle: () {
                    // Get.find<LocationController>()
                    //     .updatePosition(_cameraPosition, false);
                  },
                ),
                loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox()
                // : Positioned(
                //     top: 10,
                //     left: 10,
                //     right: 10,
                //     child: SearchLocationWidget(
                //         pickedAddress: "Dhaka", isEnabled: true)),
              ],
            ),
    );
  }
}
