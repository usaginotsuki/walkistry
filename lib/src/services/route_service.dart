import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:walkistry_flutter/src/models/route_model.dart';

class RouteHelper {
  RouteHelper();
  final String _rootUrl =
      'https://us-central1-walkistry.cloudfunctions.net/api/routes';

  Future<List<Routes>?> getRoutes() async {
    try {
      List<Routes> routes = [];
      var url = Uri.parse(_rootUrl);
      final response = await http.get(url);

      if (response.body.isEmpty) {
        return null;
      }

      developer.log(response.body, name: 'getRoutes');
      routes = (json.decode(response.body) as List)
          .map((data) => Routes.fromJson(data))
          .toList();
      developer.log(routes.toString(), name: 'routesList');
      return routes;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
