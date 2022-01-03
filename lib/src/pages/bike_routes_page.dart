// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:walkistry_flutter/src/models/route_model.dart';
import 'package:walkistry_flutter/src/services/route_service.dart';
import '../widgets/route_widget.dart';

class BikeRoutesPage extends StatefulWidget {
  BikeRoutesPage({Key? key}) : super(key: key);

  @override
  _BikeRoutesPageState createState() => _BikeRoutesPageState();
}

class _BikeRoutesPageState extends State<BikeRoutesPage> {
  final RouteHelper _routeHelper = RouteHelper();
  List<Routes>? _routes;

  @override
  void initState() {
    super.initState();
    _dowloadRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: _routes == null
            ? const Center(
                child: SizedBox.square(
                    key: Key("200"),
                    dimension: 300.0,
                    child: CircularProgressIndicator()),
              )
            : _routes!.isEmpty
                ? const Center(
                    child: Text("No hay elementos"),
                  )
                : ListView(
                    children: _routes!
                        .map((e) => ElementWidget(element: e))
                        .toList()));
  }

  _dowloadRoutes() async {
    _routes = await _routeHelper.getRoutes();
    if (mounted) {
      setState(() {});
    }
  }
}
