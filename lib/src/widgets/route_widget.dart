import 'package:flutter/material.dart';
import 'package:walkistry_flutter/src/models/route_model.dart';
import '../pages/map_page.dart';

class ElementWidget extends StatelessWidget {
  const ElementWidget({Key? key, required this.element}) : super(key: key);
  final Routes element;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(element.routeName.toString()),
        subtitle: const Text("Ruta de caminata"),
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
