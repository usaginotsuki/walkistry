import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkistry_flutter/main.dart';
import 'package:walkistry_flutter/src/bloc/login_bloc.dart';
import 'package:walkistry_flutter/src/models/login_model.dart';
import 'package:walkistry_flutter/src/providers/main_provider.dart';
import 'package:walkistry_flutter/src/services/usuario_service.dart';
import 'dart:developer' as developer;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscuredText = true;

  LoginBloc _loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  color: Colors.blue),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 120, left: 35, right: 35),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text("Inicio de sesión",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          height: 300,
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
                                          decoration: InputDecoration(
                                            errorText:
                                                snapshot.error?.toString(),
                                            labelText: "Correo electrónico",
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            icon: const Icon(
                                              Icons.email,
                                              color: Colors.black,
                                            ),
                                            hintText:
                                                "Ingrese su correo electrónico",
                                          ));
                                    }),
                                StreamBuilder<Object>(
                                    stream: _loginBloc.passwordStream,
                                    builder: (context, snapshot) {
                                      return TextField(
                                          onChanged: _loginBloc.changePassword,
                                          obscureText: _obscuredText,
                                          decoration: InputDecoration(
                                            errorText:
                                                snapshot.error?.toString(),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obscuredText
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _obscuredText =
                                                      !_obscuredText;
                                                });
                                              },
                                            ),
                                            icon: const Icon(
                                              Icons.lock,
                                              color: Colors.black,
                                            ),
                                            labelText: "Contraseña",
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            hintText: "Ingrese su contraseña",
                                          ));
                                    }),
                                StreamBuilder<bool>(
                                    stream: _loginBloc.formLoginStream,
                                    builder: (context, snapshot) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 40),
                                          child: ElevatedButton.icon(
                                              onPressed: snapshot.hasData
                                                  ? () async {
                                                      final login =
                                                          UsuarioService();
                                                      final creds = UserLogin(
                                                          email:
                                                              _loginBloc.email,
                                                          password: _loginBloc
                                                              .password);
                                                      Map<String, dynamic>
                                                          resp = await login
                                                              .login(creds);
                                                      if (resp.containsKey(
                                                          'idToken')) {
                                                        final userName =
                                                            resp['displayName'];
                                                        developer.log(
                                                            "Usuario logeado $userName",
                                                            name: "Login");
                                                        mainProvider.token =
                                                            resp['idToken'];
                                                        developer.log(
                                                            mainProvider.token,
                                                            name: "Token");
                                                      }
                                                    }
                                                  : null,
                                              icon: const Icon(Icons.login),
                                              label: const Text("Ingresar")));
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Center(
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                    child: const Text("Registrarse"))))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
