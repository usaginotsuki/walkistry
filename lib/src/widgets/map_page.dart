// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walkistry_flutter/src/models/route_model.dart';
import 'dart:developer';

class MapPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MapPage({Key? key, required this.route}) : super(key: key);
  final Routes route;
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Polyline> _polylines = {};
  List<LatLng> _polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  List<Marker> _markers = <Marker>[];
  Routes _route = Routes();
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    polylinePoints = PolylinePoints();
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
          setPolyLines();
        },
        polylines: _polylines,
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

  void setPolyLines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyBeqkn43-p2QqywEtMRu3Aij7q6U6wamV4',
        PointLatLng(
            _route.routeStart!.latitude!, _route.routeStart!.longitude!),
        PointLatLng(_route.routeStop!.latitude!, _route.routeStop!.longitude!));
    log(result.status.toString());
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      log(_route.routeStart!.latitude!.toString() +
          ' ' +
          _route.routeStart!.longitude!.toString() +
          ' ' +
          _route.routeStop!.latitude!.toString() +
          ' ' +
          _route.routeStop!.longitude!.toString());
      log("Polylines");
      log(_polylineCoordinates.toString());
      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: _polylineCoordinates));
      });
    }
  }
}
