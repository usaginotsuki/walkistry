import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:walkistry_flutter/src/bloc/login_bloc.dart';
import 'package:walkistry_flutter/src/models/login_model.dart';
import 'package:walkistry_flutter/src/providers/main_provider.dart';
import 'package:walkistry_flutter/src/services/usuario_service.dart';
import 'dart:developer' as developer;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscuredText = true;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  LoginBloc _loginBloc = LoginBloc();
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
                    padding:
                        const EdgeInsets.only(top: 120, left: 35, right: 35),
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
                                          keyboardType:
                                              TextInputType.emailAddress,
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
                                          keyboardType:
                                              TextInputType.visiblePassword,
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
                                                      developer.log(_loginBloc
                                                              .email
                                                              .toString() +
                                                          " " +
                                                          _loginBloc.password
                                                              .toString());
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
                                                        mainProvider.userId =
                                                            resp['localId'];
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
                        Column(
                          children: [
                            Center(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: SignInButton(
                                      Buttons.Email,
                                      text: "Registrarse con correo",
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/signup');
                                      },
                                    ))),
                            StreamBuilder<void>(
                                stream: null,
                                builder: (context, snapshot) {
                                  return SignInButton(Buttons.Google,
                                      text: "Ingresar con Google",
                                      onPressed: () async {
                                    await Firebase.initializeApp();
                                    final GoogleSignInAccount? googleUser =
                                        await GoogleSignIn().signIn();

                                    // Obtain the auth details from the request
                                    final GoogleSignInAuthentication?
                                        googleAuth =
                                        await googleUser?.authentication;

                                    // Create a new credential
                                    final credential =
                                        GoogleAuthProvider.credential(
                                      accessToken: googleAuth?.accessToken,
                                      idToken: googleAuth?.idToken,
                                    );
                                    developer.log("Credential: $credential",
                                        name: "Login");

                                    // Once signed in, return the UserCredential
                                    var answer = await FirebaseAuth.instance
                                        .signInWithCredential(credential);
                                    _googleSignIn.signIn().then((result) {
                                      result!.authentication.then((googleKey) {
                                        mainProvider.token =
                                            (googleKey.idToken.toString());
                                        developer.log(mainProvider.token,
                                            name: "Token - MainProvider");
                                      }).catchError((err) {
                                        print('inner error');
                                      });
                                    }).catchError((err) {
                                      print('error occured');
                                    });
                                    final login = UsuarioService();
                                    var userID = answer.user!.uid.toString();
                                    developer.log(userID,
                                        name: "UserID - Google");
                                    await login.googleLogIn(userID);
                                    developer.log(answer.user.toString(),
                                        name: "User - Google");
                                    mainProvider.userId = userID;

                                    developer.log(
                                        mainProvider.userId.toString(),
                                        name: "User-ID - Provider");
                                    Navigator.popAndPushNamed(
                                        context, "/homepage");
                                  });
                                })
                          ],
                        )
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
