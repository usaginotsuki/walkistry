// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:walkistry_flutter/src/models/user_model.dart';
import 'package:walkistry_flutter/src/pages/user_stats/bicycle_stats_page.dart';
import 'package:walkistry_flutter/src/pages/user_stats/walks_stats_page.dart';
import 'package:walkistry_flutter/src/services/user_service.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Usuario'),
        ),
        body: _user == null
            ? const Center(
                child: SizedBox.square(
                    key: Key("200"),
                    dimension: 300.0,
                    child: CircularProgressIndicator()),
              )
            : _user.toString().isEmpty
                ? const Center(
                    child: Text("No cuenta con un perfil"),
                  )
                : ListView(
                    children: [
                      Container(
                          decoration: BoxDecoration(
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
                      const SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: Text("\n" + _user!.name!,
                            style: const TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
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
                              color: Colors.white,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        physics:
                            const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                        shrinkWrap: true, // You won't see infinite size error

                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WalkStatsPage()));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              margin: const EdgeInsets.all(15),
                              elevation: 10,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      "https://images.squarespace-cdn.com/content/v1/59402b922e69cfd68984f575/1561395329336-70ZVUDE8HP458RNXR8I0/44875714_S_Feet_Shoe_Sneakers_Walking_Road.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        "Caminatas",
                                        textScaleFactor: 1.5,
                                      ))
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BikeStatsPage()));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              margin: const EdgeInsets.all(15),
                              elevation: 10,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      "https://st.depositphotos.com/1011382/2840/i/600/depositphotos_28403577-stock-photo-moutain-bike-man.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        "Bicicleta",
                                        textScaleFactor: 1.5,
                                      ))
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BikeStatsPage()));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              margin: const EdgeInsets.all(15),
                              elevation: 10,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlijGC2YdXHHsF3gBszHr0Fw2zV4ThaPHX5vfnt_oXCJp-DNeZgN6xDkpvt2O3lvPOrgI&usqp=CAU",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        "Estadisticas",
                                        textScaleFactor: 1.5,
                                      ))
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BikeStatsPage()));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              margin: const EdgeInsets.all(15),
                              elevation: 10,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      "https://www.vhv.rs/dpng/d/563-5639120_transparent-setting-clipart-settings-button-transparent-background-hd.png",
                                      fit: BoxFit.fitHeight,
                                      height: 110,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        "Editar perfil",
                                        textScaleFactor: 1.5,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ));
  }

  _dowloadUser(String id) async {
    _user = (await _userHelper.getUser(id));
    if (mounted) {
      setState(() {});
    }
  }
}
