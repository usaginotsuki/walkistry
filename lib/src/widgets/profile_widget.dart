// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:walkistry_flutter/src/models/user_model.dart';
import 'package:walkistry_flutter/src/services/user_service.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final UserHelper _userHelper = UserHelper();

  User? _user;

  @override
  void initState() {
    _dowloadUser('6KoU5EzwSlhh3QCZ3QLh');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _user == null
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
                : Card(
                    child: Container(
                        child: FloatingActionButton(
                          child: const Icon(Icons.add),
                          onPressed: () {},
                        ),
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.deepOrange,
                              Colors.pinkAccent
                            ]))),
                  ));
  }

  _dowloadUser(String id) async {
    _user = (await _userHelper.getUser(id));
    if (mounted) {
      setState(() {});
    }
  }
}

/*Widget _searchCard() => Container(
      child: Card(
        color: Colors.lightGreen[100],
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(41, 47, 54, 1),
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.black38),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Color.fromRGBO(41, 47, 54, 1),
                  ),
                  cursorColor: Color.fromRGBO(41, 47, 54, 1),
                  textInputAction: TextInputAction.search,
                  autocorrect: false,
                ),
              ),
              Icon(
                Icons.menu,
                color: Color.fromRGBO(41, 47, 54, 1),
              ),
            ],
          ),
        ),
      ),
    );
*/