// ignore_for_file: prefer_const_constructors_in_immutables, override_on_non_overriding_member

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walkistry_flutter/src/models/stats/walk_list_model.dart';

class MapStatsPage extends StatefulWidget {
  MapStatsPage({Key? key, required this.walk}) : super(key: key);
  final WalkList walk;
  @override
  _MapStatsPageState createState() => _MapStatsPageState();
}

class _MapStatsPageState extends State<MapStatsPage> {
  @override
  List<Marker> _markers = <Marker>[];

  WalkList _walk = WalkList();

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    _walk = widget.walk;
    _addMarker(_walk);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Stats'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(
              (_walk.startingPoint!.latitude! +
                      _walk.finishingPoint!.latitude!) /
                  2,
              (_walk.startingPoint!.longitude! +
                      _walk.finishingPoint!.longitude!) /
                  2),
          zoom: 15.5,
          tilt: 50,
        ),
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_markers),
      ),
    );
  }

  void _addMarker(WalkList walk) {
    _markers.add(Marker(
      markerId: MarkerId('Start'),
      position:
          LatLng(walk.startingPoint!.latitude!, walk.startingPoint!.longitude!),
    ));
    _markers.add(Marker(
      markerId: MarkerId('Start'),
      position: LatLng(
          walk.finishingPoint!.latitude!, walk.finishingPoint!.longitude!),
    ));
    if (mounted) {
      setState(() {});
    }
  }
}
