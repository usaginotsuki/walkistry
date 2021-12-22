// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:walkistry_flutter/src/models/stats/walk_list_model.dart';
import 'package:walkistry_flutter/src/services/user_service.dart';
import 'package:walkistry_flutter/src/widgets/walk_list_widget.dart';

class BikeStatsPage extends StatefulWidget {
  BikeStatsPage({Key? key}) : super(key: key);

  @override
  _BikeStatsPageState createState() => _BikeStatsPageState();
}

class _BikeStatsPageState extends State<BikeStatsPage> {
  final UserHelper _userHelper = UserHelper();

  List<WalkList>? _listWalk;

  @override
  void initState() {
    _dowloadWalks('6KoU5EzwSlhh3QCZ3QLh');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recorridos en bicicleta previos'),
      ),
      body: ListView(children: [
        _listWalk == null
            ? const Center(
                child: SizedBox.square(
                    key: Key("200"),
                    dimension: 300.0,
                    child: CircularProgressIndicator()),
              )
            : _listWalk!.isEmpty
                ? const Center(
                    child: Text("No hay elementos"),
                  )
                : ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _listWalk!
                        .map((e) => WalkListWidget(walks: e))
                        .toList(),
                  ),
      ]),
    );
  }

  _dowloadWalks(String id) async {
    _listWalk = await _userHelper.getWalks(id);
    if (mounted) {
      setState(() {});
    }
  }
}
