// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkistry_flutter/src/models/user_model.dart';
import 'package:walkistry_flutter/src/pages/user_stats/bicycle_stats_page.dart';
import 'package:walkistry_flutter/src/pages/user_stats/profile_edit_page.dart';
import 'package:walkistry_flutter/src/pages/user_stats/walks_stats_page.dart';
import 'package:walkistry_flutter/src/providers/main_provider.dart';
import 'package:walkistry_flutter/src/services/user_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserHelper _userHelper = UserHelper();

  User? _user;

  @override
  void initState() {
    _dowloadUser('6KoU5EzwSlhh3QCZ3QLh');
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return SizedBox(
      height: 350,
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SpeedDial(
            animatedIcon: AnimatedIcons.menu_home,
            animatedIconTheme: IconThemeData(size: 22.0),
            direction: SpeedDialDirection.down,
            visible: true,
            curve: Curves.bounceIn,
            children: [
              SpeedDialChild(
                child: Icon(Icons.perm_identity),
                backgroundColor: Colors.blue,
                label: 'Editar perfil',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileEditPage()),
                  );
                },
              ),
              SpeedDialChild(
                child: Icon(Icons.directions_bike),
                backgroundColor: Colors.blue,
                label: 'Estadisticas de bicicleta',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BikeStatsPage()),
                  );
                },
              ),
              SpeedDialChild(
                child: Icon(Icons.directions_walk),
                backgroundColor: Colors.blue,
                label: 'Estadisticas de caminata',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WalkStatsPage()),
                  );
                },
              ),
              SpeedDialChild(
                child: Icon(Icons.close),
                backgroundColor: Colors.blue,
                label: 'Cerrar sesión',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  mainProvider.logout();

                  setState(() {});
                },
              ),
            ],
          ),
        ),
        body: _user == null
            ? Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg?size=626&ext=jpg&ga=GA1.2.1210289799.1638662400'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: SizedBox(
                        height: 200,
                        child: Container(
                          alignment: const Alignment(0.0, 2.5),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1024px-User-avatar.svg.png'),
                            radius: 60.0,
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Text("\nBuscando datos de usuario",
                        style: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              )
            : _user.toString().isEmpty
                ? const Center(
                    child: Text("No cuenta con un perfil"),
                  )
                : Column(children: [
                    Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(_user!.background ??
                                'https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg?size=626&ext=jpg&ga=GA1.2.1210289799.1638662400'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: SizedBox(
                          height: 200,
                          child: Container(
                            alignment: const Alignment(0.0, 2.5),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(_user!.avatar ??
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1024px-User-avatar.svg.png'),
                              radius: 60.0,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Text("\n" + _user!.name!,
                          style: const TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w600)),
                    ),
                    Center(
                      child: Text(
                        "Peso : " +
                            _user!.weight.toString() +
                            " Kg - " +
                            "\t" +
                            "Altura : " +
                            _user!.height.toString() +
                            " cm\n Fecha de nacimiento : " +
                            _user!.dateOfBirth!.seconds!.year.toString() +
                            " / " +
                            _user!.dateOfBirth!.seconds!.month.toString(),
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }

  _dowloadUser(String id) async {
    _user = (await _userHelper.getUser(id));
    if (mounted) {
      setState(() {});
    }
  }
}
