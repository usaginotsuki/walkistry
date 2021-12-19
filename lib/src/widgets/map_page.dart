// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walkistry_flutter/src/models/route_model.dart';

class MapPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MapPage({Key? key, required this.route}) : super(key: key);
  final Routes route;
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Marker> _markers = <Marker>[];
  Routes _route = Routes();
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    _route = widget.route;
    _addMarker(_route);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(
              (_route.routeStart!.latitude! + _route.routeStop!.latitude!) / 2,
              (_route.routeStart!.longitude! + _route.routeStop!.longitude!) /
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

  void _addMarker(Routes route) {
    _markers.add(Marker(
      markerId: MarkerId('Start'),
      position:
          LatLng(route.routeStart!.latitude!, route.routeStart!.longitude!),
    ));
    _markers.add(Marker(
      markerId: MarkerId('Start'),
      position: LatLng(route.routeStop!.latitude!, route.routeStop!.longitude!),
    ));
    if (mounted) {
      setState(() {});
    }
  }
}
