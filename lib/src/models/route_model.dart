// To parse this JSON data, do
//
//     final routes = routesFromJson(jsonString);

import 'dart:convert';

List<Routes> routesFromJson(String str) =>
    List<Routes>.from(json.decode(str).map((x) => Routes.fromJson(x)));

String routesToJson(List<Routes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Routes {
  Routes({
    this.routeName,
    this.routeStop,
    this.routeStart,
    this.routeLenght,
  });

  String? routeName;
  RouteSt? routeStop;
  RouteSt? routeStart;
  double? routeLenght;

  factory Routes.fromJson(Map<String, dynamic> json) => Routes(
        routeName: json["routeName"],
        routeStop: RouteSt.fromJson(json["routeStop"]),
        routeStart: RouteSt.fromJson(json["routeStart"]),
        routeLenght: json["routeLenght"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "routeName": routeName,
        "routeStop": routeStop!.toJson(),
        "routeStart": routeStart!.toJson(),
        "routeLenght": routeLenght,
      };
}

class RouteSt {
  RouteSt({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory RouteSt.fromJson(Map<String, dynamic> json) => RouteSt(
        latitude: json["_latitude"].toDouble(),
        longitude: json["_longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_latitude": latitude,
        "_longitude": longitude,
      };
}
