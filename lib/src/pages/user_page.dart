import 'package:flutter/material.dart';
import 'package:walkistry_flutter/src/models/user_model.dart';
import 'package:walkistry_flutter/src/models/walk_list_model.dart';
import 'package:walkistry_flutter/src/services/user_service.dart';
import 'package:walkistry_flutter/src/widgets/walk_list_widget.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserHelper _userHelper = UserHelper();

  List<WalkList>? _listWalk;
  User? _user;

  @override
  void initState() {
    _dowloadUser('6KoU5EzwSlhh3QCZ3QLh');
    _dowloadWalks('6KoU5EzwSlhh3QCZ3QLh');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Usuario'),
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
                : ListView(children: [
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
                            alignment: Alignment(0.0, 2.5),
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
                                physics: const ClampingScrollPhysics(),
                                children: _listWalk!
                                    .map((e) => WalkListWidget(walks: e))
                                    .toList(),
                              ),
                  ]));
  }

  _dowloadUser(String id) async {
    _user = (await _userHelper.getUser(id));
    if (mounted) {
      setState(() {});
    }
  }

  _dowloadWalks(String id) async {
    _listWalk = await _userHelper.getWalks(id);
    if (mounted) {
      setState(() {});
    }
  }
}
