import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({Key? key, required this.image}) : super(key: key);

  final String? image;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: Image.network(
        image!,
        fit: BoxFit.cover,
      ),
    );
  }
}
