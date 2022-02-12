import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Sign Up'),
            ),
            body: SingleChildScrollView(
                child: Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    color: Colors.blue)
              ],
            ))));
  }
}
