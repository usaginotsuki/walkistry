// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print, unused_local_variable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:walkistry_flutter/src/models/user_model.dart';
import 'package:walkistry_flutter/src/services/photo_service.dart';
import 'package:walkistry_flutter/src/services/user_service.dart';
import 'package:walkistry_flutter/src/widgets/image_full_screen.dart';

import 'package:walkistry_flutter/tab_bar.dart';

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({Key? key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final UserHelper _userHelper = UserHelper();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  User? _user;
  final _formKey = GlobalKey<FormState>();
  bool _onSaving = false;
  final UpdateService _updateService = UpdateService();
  File? _image_back;

  @override
  void initState() {
    super.initState();
    _dowloadUser('6KoU5EzwSlhh3QCZ3QLh');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              BackButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeTabBar()));
                },
              ),
              IconButton(
                onPressed: () {
                  _sendForm('6KoU5EzwSlhh3QCZ3QLh');
                },
                icon: _onSaving ? Icon(Icons.check) : Icon(Icons.save),
                color: Colors.black,
              )
            ],
            elevation: 0),
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImage(
                              image: _user!.background ??
                                  'https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg?size=626&ext=jpg&ga=GA1.2.1210289799.1638662400',
                            ),
                          ),
                        );
                      },
                      child: Stack(children: [
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
                        Container(
                          padding: const EdgeInsets.only(left: 320, top: 20),
                          child: FloatingActionButton(
                            heroTag: null,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text('Editar foto de portada'),
                                        actions: [
                                          ElevatedButton.icon(
                                            icon: const Icon(Icons.camera_alt),
                                            onPressed: () =>
                                                _selectImageBackground(
                                                    ImageSource.camera),
                                            label: Text("Tomar foto"),
                                          ),
                                          ElevatedButton.icon(
                                            icon: const Icon(Icons.image),
                                            onPressed: () =>
                                                _selectImageBackground(
                                                    ImageSource.gallery),
                                            label:
                                                Text("Seleccionar de galeria"),
                                          )
                                        ],
                                      ));
                            },
                            backgroundColor: Colors.green,
                            child: const Icon(Icons.edit),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(left: 230, top: 170),
                            child: FloatingActionButton(
                              child: const Icon(Icons.edit),
                              backgroundColor: Colors.green,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: Text('Editar foto de portada'),
                                          actions: [
                                            ElevatedButton.icon(
                                              icon:
                                                  const Icon(Icons.camera_alt),
                                              onPressed: () => _selectImage(
                                                  ImageSource.camera),
                                              label: Text("Tomar foto"),
                                            ),
                                            ElevatedButton.icon(
                                              icon: const Icon(Icons.image),
                                              onPressed: () => _selectImage(
                                                  ImageSource.gallery),
                                              label: Text(
                                                  "Seleccionar de galeria"),
                                            )
                                          ],
                                        ));
                              },
                            ))
                      ]),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(children: [
                            TextFormField(
                              keyboardType: TextInputType.name,
                              initialValue: _user!.name.toString(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Datos incorrectos";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                //Evento al ser guardado el formulario
                                _user!.name = value;
                              },
                              decoration: const InputDecoration(
                                  labelText: "Nombre",
                                  labelStyle: TextStyle(fontSize: 25)),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: _user!.height.toString(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Datos incorrectos";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                //Evento al ser guardado el formulario
                                _user!.height = int.tryParse(value!);
                              },
                              decoration: const InputDecoration(
                                  labelText: "Altura (cm)",
                                  labelStyle: TextStyle(fontSize: 25)),
                            ),
                            Padding(padding: EdgeInsets.all(20)),
                            Text(
                              "Fecha de Nacimiento",
                              textScaleFactor: 1.5,
                              textAlign: TextAlign.left,
                            ),
                            DatePickerWidget(
                              lastDate: DateTime.now(),
                              initialDate: _user!.dateOfBirth!.seconds,
                              locale: DatePicker.localeFromString('es'),
                              onChange: (DateTime newDate, _) {
                                _user!.dateOfBirth!.seconds = newDate;
                                print("Usuario: " +
                                    _user!.dateOfBirth!.seconds.toString());
                                print(newDate);
                              },
                            ),
                          ]),
                        ))
                  ]));
  }

  _selectImage(ImageSource source) async {
    XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _user!.avatar = await _updateService.uploadImage(_image!);
    } else {
      _image = null;
    }

    if (mounted) {
      setState(() {});
    }
  }

  _selectImageBackground(ImageSource source) async {
    XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _image_back = File(pickedFile.path);
      _user!.background = await _updateService.uploadImage(_image_back!);
    } else {
      _image_back = null;
    }
    if (mounted) {
      setState(() {});
    }
  }

  _dowloadUser(String id) async {
    _user = (await _userHelper.getUser(id));
    if (mounted) {
      setState(() {});
    }
  }

  _sendForm(String id) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    _onSaving = true;
    if (mounted) {
      setState(() {});
    }
    String status =
        await _updateService.postUser(_user!, '6KoU5EzwSlhh3QCZ3QLh');
  }
}
