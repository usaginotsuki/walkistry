import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkistry_flutter/src/bloc/login_bloc.dart';
import 'package:walkistry_flutter/src/models/login_model.dart';
import 'package:walkistry_flutter/src/providers/main_provider.dart';
import 'dart:developer' as developer;

import 'package:walkistry_flutter/src/services/usuario_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  LoginBloc _loginBloc = LoginBloc();
  bool _obscuredText = true;
  bool _obscuredText2 = true;
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(children: [
      Container(
          height: MediaQuery.of(context).size.height * 0.4, color: Colors.blue),
      Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text("Registrate!",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                  ),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 4),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 25),
                      child: Column(
                        children: [
                          StreamBuilder<String>(
                              stream: _loginBloc.emailStream,
                              builder: (context, snapshot) {
                                return TextField(
                                    onChanged: _loginBloc.changeEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      errorText: snapshot.error?.toString(),
                                      labelText: "Correo electrónico",
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      icon: const Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                      hintText: "Ingrese su correo electrónico",
                                    ));
                              }),
                          StreamBuilder<Object>(
                              stream: _loginBloc.comparePassword,
                              builder: (context, snapshot) {
                                return TextField(
                                    onChanged: _loginBloc.changePasswordChecker,
                                    obscureText: _obscuredText2,
                                    decoration: InputDecoration(
                                      errorText: snapshot.error?.toString(),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscuredText2
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscuredText2 = !_obscuredText2;
                                          });
                                        },
                                      ),
                                      icon: const Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                      ),
                                      labelText: "Confirme su contraseña",
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      hintText: "Confirme su contraseña",
                                    ));
                              }),
                          StreamBuilder<Object>(
                              stream: _loginBloc.passwordStream,
                              builder: (context, snapshot) {
                                return TextField(
                                    onChanged: _loginBloc.changePassword,
                                    obscureText: _obscuredText,
                                    decoration: InputDecoration(
                                      errorText: snapshot.error?.toString(),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscuredText
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscuredText = !_obscuredText;
                                          });
                                        },
                                      ),
                                      icon: const Icon(
                                        Icons.lock,
                                        color: Colors.black,
                                      ),
                                      labelText: "Contraseña",
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      hintText: "Ingrese su contraseña",
                                    ));
                              }),
                          StreamBuilder<bool>(
                              stream: _loginBloc.formLoginStream,
                              builder: (context, snapshot) {
                                return Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: ElevatedButton.icon(
                                        onPressed: snapshot.hasData
                                            ? _loginBloc.password.toString() ==
                                                    _loginBloc.passwordChecker
                                                        .toString()
                                                ? () async {
                                                    final login =
                                                        UsuarioService();
                                                    final creds = UserLogin(
                                                        email: _loginBloc.email,
                                                        password: _loginBloc
                                                            .password);
                                                    Map<String, dynamic> resp =
                                                        await login
                                                            .register(creds);
                                                    if (resp.containsKey(
                                                        'idToken')) {
                                                      developer.log(
                                                          resp.toString(),
                                                          name: "Resp");
                                                      final userName =
                                                          resp['displayName'];
                                                      developer.log(
                                                          "Usuario logeado $userName",
                                                          name: "Login");
                                                      mainProvider.token =
                                                          resp['idToken'];
                                                      mainProvider.userId =
                                                          resp['localId'];
                                                      developer.log(
                                                          mainProvider.userId,
                                                          name: "UserID");
                                                      developer.log(
                                                          mainProvider.token,
                                                          name: "Token");
                                                      Navigator.popAndPushNamed(
                                                          context, '/homepage');
                                                    }
                                                  }
                                                : null
                                            : null,
                                        icon: const Icon(Icons.login),
                                        label: const Text("Registrarse")));
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ))
        ],
      )
    ])));
  }
}
