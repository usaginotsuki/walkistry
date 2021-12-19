import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:walkistry_flutter/src/models/stats/walk_list_model.dart';
import 'package:walkistry_flutter/src/pages/user_stats/map_stats_page.dart';

class WalkListWidget extends StatelessWidget {
  const WalkListWidget({Key? key, required this.walks}) : super(key: key);
  final WalkList walks;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(returnMonth(walks.date!.seconds!) +
                " - " +
                walks.date!.seconds!.day.toString()),
            subtitle: const Text("Ruta de caminata"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MapStatsPage(walk: walks)));
            }));
  }

  String returnMonth(DateTime date) {
    return DateFormat.MMMM().format(date);
  }
}
