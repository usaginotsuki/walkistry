import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:walkistry_flutter/src/models/route_model.dart';
import 'map_page.dart';

class ElementWidget extends StatelessWidget {
  const ElementWidget({Key? key, required this.element}) : super(key: key);
  final Routes element;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(element.routeName.toString()),
        subtitle: Text(Geolocator.distanceBetween(
                    element.routeStart!.latitude!,
                    element.routeStart!.longitude!,
                    element.routeStop!.latitude!,
                    element.routeStop!.longitude!)
                .toInt()
                .toString() +
            " m"),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MapPage(
                        route: element,
                      )));
        },
      ),
    );
  }
}
