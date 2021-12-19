import 'package:flutter/material.dart';
import 'package:walkistry_flutter/src/models/walk_list_model.dart';

class WalkListWidget extends StatelessWidget {
  const WalkListWidget({Key? key, required this.walks}) : super(key: key);
  final WalkList walks;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(walks.date!.seconds.toString()),
            subtitle: const Text("Ruta de caminata"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {}));
  }
}
