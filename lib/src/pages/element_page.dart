import 'package:flutter/material.dart';
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
        subtitle: Text("Atomic #" + element.routeStart!.latitude.toString()),
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
  /*showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("Close"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(element.routeName.toString()),
      content: ListView(
        children: <Widget>[
          /*GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(element.routeStart!.latitude!,
                  element.routeStart!.longitude!),
              zoom: 14.0,
            ),
          ),*/
        ],
      ),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}*/
