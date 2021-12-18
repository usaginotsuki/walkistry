import 'package:flutter/material.dart';
import 'package:walkistry_flutter/src/models/route_model.dart';
import 'package:walkistry_flutter/src/services/route_service.dart';
import 'element_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RouteHelper _routeHelper = RouteHelper();
  List<Routes>? _routes;

  @override
  void initState() {
    super.initState();
    _dowloadRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Routes'),
        ),
        body: _routes == null
            ? const SizedBox.square(
                key: Key("200"),
                dimension: 300.0,
                child: CircularProgressIndicator())
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
