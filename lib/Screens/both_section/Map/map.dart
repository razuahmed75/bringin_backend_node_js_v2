import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../controllers/recruiter_section/map_controll.dart';

class BothMapScreen extends StatefulWidget {
  final LatLng latLng;
  const BothMapScreen({super.key, required this.latLng});

  @override
  State<BothMapScreen> createState() => _BothMapScreenState();
}

class _BothMapScreenState extends State<BothMapScreen> {
  GoogleMapController? _mapController;
  CameraPosition? _cameraPosition;

  final mapcontroll = Get.put(MapControll());

  bool loading = false;

  // Future loaddata() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   await mapcontroll.determinePosition();
  //   _initialPosition = LatLng(
  //     mapcontroll.position!.latitude,
  //     mapcontroll.position!.longitude,
  //   );
  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  void initState() {
    // loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: widget.latLng,
                    zoom: 16,
                  ),
                  minMaxZoomPreference: MinMaxZoomPreference(0, 16),
                  myLocationButtonEnabled: false,
                  markers: {
                    Marker(markerId: MarkerId("4"), position: widget.latLng)
                  },
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
              ],
            ),
    );
  }
}
